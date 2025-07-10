def json_stringify(obj, options = {})
  indent = options[:indent] || 0
  pretty = options[:pretty] || false
  current_indent = options[:current_indent] || 0
  
  case obj
  when Hash
    stringify_hash(obj, indent, pretty, current_indent)
  when Array
    stringify_array(obj, indent, pretty, current_indent)
  when String
    stringify_string(obj)
  when Numeric
    stringify_number(obj)
  when TrueClass, FalseClass
    obj.to_s
  when NilClass
    'null'
  else
    stringify_string(obj.to_s)
  end
end

def stringify_hash(hash, indent, pretty, current_indent)
  return '{}' if hash.empty?
  
  if pretty
    inner_indent = current_indent + indent
    newline = "\n"
    space = " " * inner_indent
    closing_space = " " * current_indent
    
    result = "{\n"
    pairs = []
    
    hash.each do |key, value|
      key_str = stringify_string(key.to_s)
      value_str = json_stringify(value, 
        indent: indent, 
        pretty: pretty, 
        current_indent: inner_indent
      )
      pairs << "#{space}#{key_str}: #{value_str}"
    end
    
    result += pairs.join(",\n")
    result += "\n#{closing_space}}"
  else
    pairs = []
    hash.each do |key, value|
      key_str = stringify_string(key.to_s)
      value_str = json_stringify(value, indent: indent, pretty: pretty, current_indent: current_indent)
      pairs << "#{key_str}:#{value_str}"
    end
    "{#{pairs.join(',')}}"
  end
end

def stringify_array(array, indent, pretty, current_indent)
  return '[]' if array.empty?
  
  if pretty
    inner_indent = current_indent + indent
    newline = "\n"
    space = " " * inner_indent
    closing_space = " " * current_indent
    
    result = "[\n"
    elements = []
    
    array.each do |item|
      item_str = json_stringify(item, 
        indent: indent, 
        pretty: pretty, 
        current_indent: inner_indent
      )
      elements << "#{space}#{item_str}"
    end
    
    result += elements.join(",\n")
    result += "\n#{closing_space}]"
  else
    elements = []
    array.each do |item|
      item_str = json_stringify(item, indent: indent, pretty: pretty, current_indent: current_indent)
      elements << item_str
    end
    "[#{elements.join(',')}]"
  end
end

def stringify_string(str)
  escaped = str.gsub(/\\/, '\\\\')
               .gsub(/"/, '\\"')
               .gsub(/\n/, '\\n')
               .gsub(/\t/, '\\t')
               .gsub(/\r/, '\\r')
               .gsub(/\b/, '\\b')
               .gsub(/\f/, '\\f')
  
  "\"#{escaped}\""
end

def stringify_number(num)
  if num.is_a?(Float)
    if num.infinite?
      'null'
    elsif num.nan?
      'null'
    else
      # Remove trailing zeros for cleaner output
      formatted = num.to_s
      formatted.sub(/\.0+$/, '') == formatted.to_i.to_s ? formatted.to_i.to_s : formatted
    end
  else
    num.to_s
  end
end

def json_pretty_stringify(obj, indent = 2)
  json_stringify(obj, pretty: true, indent: indent)
end

def json_compact_stringify(obj)
  json_stringify(obj, pretty: false)
end