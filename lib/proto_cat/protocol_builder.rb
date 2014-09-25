require_relative 'protocol_method'

module ProtoCat
  class ProtocolBuilder

    attr_reader :criteria

    def initialize
      @criteria = []
    end

    def has_method(*args)
      @criteria.push(ProtocolMethod.new(*args))
    end

  end
end
