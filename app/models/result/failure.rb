module Result
  class Failure
    extend ActiveModel::Naming

    def initialize(msg_key = nil, errors: nil)
      @errors = ActiveModel::Errors.new(self)

      if msg_key
        errors.add(:base, msg_key)
      end

      if errors.present?
        @errors.merge(errors)
      end
    end

    def valid?
      false
    end

    def read_attribute_for_validation(attr)
      send(attr)
    end

    def self.human_attribute_name(attr, options = {})
      attr
    end

    def self.lookup_ancestors
      [self]
    end
  end
end
