module Callable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # permite Service.call(...) ao invés de Service.new(...).call
    def call(*args, &block)
      new(*args, &block).call
    end
  end
end
