module Types
  class MutationType < Types::BaseObject
    field :connect, mutation: Mutations::Connect
    field :inspect, mutation: Mutations::Inspect
    field :destroy, mutation: Mutations::Destroy
    field :discardRandom, mutation: Mutations::DiscardRandom
    field :discard, mutation: Mutations::Discard
    field :stack, mutation: Mutations::Stack
    field :unstack, mutation: Mutations::Unstack
    field :draw, mutation: Mutations::Draw
    field :install, mutation: Mutations::Install
    field :bounce, mutation: Mutations::Bounce
    field :retrieve, mutation: Mutations::Retrieve
    field :transfer, mutation: Mutations::Transfer
    field :disconnect, mutation: Mutations::Disconnect
    field :win, mutation: Mutations::Win
  end
end
