module ProtoCat
  class ProtocolMethod

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def satisfied_by?(object)
      object.methods.include?(name)
    end

    def failure_string
      "#{name} not found"
    end

    alias_method :to_s, :name

  end
end
