require 'forwardable'
require_relative('../proto_cat')

module ProtoCat

  class ProtocolModule
    extend Forwardable
    def_delegators :protocol, :===, :must
  end

  class Protocol

    alias_method :===, :satisfied_by?

    def must
      Enforcer.new(self)
    end

    Enforcer = Struct.new(:protocol) do
      extend Forwardable
      def_delegator :protocol, :satisfied_by!, :===
    end

  end

end
