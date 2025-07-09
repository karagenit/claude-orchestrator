def deep_clone(obj)
  case obj
  when Array
    obj.map { |item| deep_clone(item) }
  when Hash
    result = {}
    obj.each { |key, value| result[deep_clone(key)] = deep_clone(value) }
    result
  when String
    obj.dup
  else
    obj
  end
end