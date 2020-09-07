class GraphqlChannel < ApplicationChannel::Channel
  def subscribed
    @subscription_ids = []
  end

  def execute(data)
    variables = prepare_variables(data[:variables])
    query = data[:query]
    operation_name = data[:operationName]
    context = { channel: self }

    result = CntrlSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name,
    )

    if subscription_id = result.context[:subscription_id]
      @subscription_ids << subscription_id
    end

    transit(result: result.to_h, more: result.subscription?)
  rescue StandardError => e
    ### TODO is this right?
    transmit exception_payload(e)
  end

  def unsubscribed
    @subscription_ids.each do |subscription_id|
      CntrlSchema.subscriptions.delete_subscription(subscription_id)
    end
  end

  private

  ##
  # Handle variables in form data, JSON body, or a blank value
  #
  # @return [Hash]
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      # GraphQL-Ruby will validate name and type of incoming variables.
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  ##
  #
  # @param exn [Exception]
  # @return [Hash]
  def exception_payload(exn)
    if Rails.application.config.consider_all_requests_local
      {
        errors: [
          message: exn.message,
          extensions: {
            exception: exn.class.name,
            message: exn.message,
            backtrace: exn.backtrace,
          },
        ],
      }
    else
      logger.fatal exn
      { errors: [message: t(".error")] }
    end
  end
end
