module Types
  class CardMetalType < BaseEnum
    description <<~DESC
      The metal that our fuel cell is made of.
    DESC

    value "SILVER", value: :silver
    value "BRONZE", value: :bronze
  end
end
