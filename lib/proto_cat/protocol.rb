require_relative 'error/not_implemented_error'

module ProtoCat
  class Protocol

    def initialize(mod, criteria)
      @module = mod
      @criteria = criteria
    end

    def satisfied_by!(object)
      satisfied_by?(object) or raise NotImplementedError.new(self, object)
    end

    def satisfied_by?(object)
      @criteria.all? {|crit| crit.satisfied_by?(object) }
    end

    def failed_criteria(object)
      @criteria.reject {|crit| crit.satisfied_by?(object) }
    end

    def failure_strings(object)
      failed_criteria(object).map(&:failure_string)
    end

    def to_s
      @module.to_s
    end

  end
end
