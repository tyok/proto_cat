require_relative('proto_cat/protocol_module')
require_relative('proto_cat/object')

module ProtoCat
  extend self

  def define_protocol(&block)
    ProtocolModule.new(&block)
  end

  def object(obj)
    Object.new(obj)
  end

end
