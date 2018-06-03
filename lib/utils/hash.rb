class Hash
  # Try provided path on hash
  #
  # == Parameters:
  # args::
  #   Keys of hash you want to try
  #
  # == Returns:
  #   Value or nil if key does not exist
  #
  def try_path(*args)
    value = self
    args.each { |arg_name| value = value.nil? ? nil : value[arg_name] }
    value
  end
end

class NilClass
  def try_path(*_args)
    nil
  end
end
