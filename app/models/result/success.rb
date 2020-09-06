module Result
  class Success < Struct.new(:payload)
    def valid?
      true
    end
  end
end
