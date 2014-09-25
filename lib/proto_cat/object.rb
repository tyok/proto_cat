module ProtoCat
  class Object

    def initialize(object)
      @object = object
    end

    def satisfy?(protocol)
      protocol.satisfied_by?(@object)
    end

    def satisfy!(protocol)
      protocol.satisfied_by!(@object)
    end

  end
end
