module Types
  class SubscriptionType < BaseObject
    field :action, subscription: Subscriptions::Action
  end
end
