class GraphqlController < ApplicationController
  rescue_from StandardError, with: :handle_exception

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {}

    result = CntrlSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name,
    )

    render json: result
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
  def handle_exception(exn)
    if Rails.application.config.consider_all_requests_local
      render json: {
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
      render json: { errors: [message: t(".error")] }
    end
  end
end
