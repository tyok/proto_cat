module ProtoCat
  class NotImplementedError < StandardError

    attr_reader :protocol, :object

    def initialize(protocol, object)
      @protocol = protocol
      @object = object

      super(not_implemented_message)
    end

    def not_implemented_message
      "#{protocol} is not implemented properly on #{object}: #{failure_string}"
    end

    def failure_string
      protocol.failure_strings(object).join('\n')
    end

  end
end
