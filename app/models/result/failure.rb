module Result
  class Failure
    extend ActiveModel::Naming

    attr_reader :errors

    def self.model(model)
      new(base).tap do |obj|
        obj.errors.merge(model.errors)
      end
    end

    def self.specific(value, key, msg)
      new(value).tap do |obj|
        obj.errors.add(key, msg)
      end
    end

    # @no-doc
    def initialize(value)
      @errors = ActiveModel::Errors.new(self)
      @value = value
    end

    def valid?
      false
    end

    def read_attribute_for_validation(attr)
      @value
    end

    def self.human_attribute_name(attr, options = {})
      attr
    end

    def self.lookup_ancestors
      [self]
    end
  end
end
