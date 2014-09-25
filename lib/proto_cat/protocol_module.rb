require 'forwardable'
require_relative 'protocol'
require_relative 'protocol_builder'

module ProtoCat
  class ProtocolModule < Module
    extend Forwardable

    def_delegators :protocol, :satisfied_by?, :satisfied_by!
    attr_reader :protocol

    def initialize(&block)
      builder = ProtocolBuilder.new
      block.call(builder)
      @protocol = Protocol.new(self, builder.criteria)
    end

    def included(klass)
      protocol.satisfied_by!(Class.new(klass))
    end

    def extended(obj)
      protocol.satisfied_by!(obj)
    end

    Class = Struct.new(:object) do
      extend Forwardable
      def_delegator :object, :instance_methods, :methods
    end

  end
end
