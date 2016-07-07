require "active_job/arguments"

module ActiveJob
  module Arguments
    private

    def deserialize_argument(argument)
      case argument
      when *TYPE_WHITELIST
        argument
      when Array
        argument.map { |arg| deserialize_argument(arg) }
      when Hash
        if serialized_global_id?(argument)
          deserialize_global_id argument
        else
          deserialize_hash(argument)
        end
      else
        raise ArgumentError, "Can only deserialize primitive arguments: #{argument.inspect}"
      end
    end
  end
end
