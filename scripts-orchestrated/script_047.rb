def sql_escape(value, quote_char = "'")
  return "NULL" if value.nil?
  
  case value
  when String
    escape_string(value, quote_char)
  when Integer, Float
    value.to_s
  when TrueClass, FalseClass
    value.to_s.upcase
  when Time, Date, DateTime
    escape_string(value.to_s, quote_char)
  else
    escape_string(value.to_s, quote_char)
  end
end

def escape_string(string, quote_char = "'")
  return "#{quote_char}#{quote_char}" if string.empty?
  
  escaped = string.dup
  
  escaped = escaped.gsub("\\", "\\\\")
  
  escaped = escaped.gsub(quote_char, "\\#{quote_char}")
  
  escaped = escaped.gsub("\0", "\\0")
  escaped = escaped.gsub("\n", "\\n")
  escaped = escaped.gsub("\r", "\\r")
  escaped = escaped.gsub("\t", "\\t")
  escaped = escaped.gsub("\b", "\\b")
  escaped = escaped.gsub("\f", "\\f")
  escaped = escaped.gsub("\v", "\\v")
  
  escaped = escaped.gsub(/[\x00-\x1F\x7F]/) do |char|
    "\\x#{char.ord.to_s(16).upcase.rjust(2, '0')}"
  end
  
  "#{quote_char}#{escaped}#{quote_char}"
end

def escape_identifier(identifier)
  return nil if identifier.nil?
  return '""' if identifier.empty?
  
  escaped = identifier.gsub('"', '""')
  "\"#{escaped}\""
end

def build_where_clause(conditions)
  return "" if conditions.nil? || conditions.empty?
  
  clauses = []
  
  conditions.each do |key, value|
    escaped_key = escape_identifier(key.to_s)
    
    case value
    when Array
      if value.empty?
        clauses << "#{escaped_key} IN ()"
      else
        escaped_values = value.map { |v| sql_escape(v) }
        clauses << "#{escaped_key} IN (#{escaped_values.join(', ')})"
      end
    when Range
      start_val = sql_escape(value.first)
      end_val = sql_escape(value.last)
      clauses << "#{escaped_key} BETWEEN #{start_val} AND #{end_val}"
    when nil
      clauses << "#{escaped_key} IS NULL"
    else
      escaped_value = sql_escape(value)
      clauses << "#{escaped_key} = #{escaped_value}"
    end
  end
  
  clauses.empty? ? "" : "WHERE #{clauses.join(' AND ')}"
end

if __FILE__ == $0
  test_values = [
    "Hello World",
    "O'Reilly",
    'Quote "test" here',
    "Line\nbreak",
    "Tab\there",
    "Backslash\\test",
    "Null\0character",
    "Control\x01character",
    "",
    nil,
    123,
    45.67,
    true,
    false,
    [1, 2, 3],
    1..10
  ]
  
  puts "=== SQL Escape Tests ==="
  test_values.each do |value|
    escaped = sql_escape(value)
    puts "#{value.inspect} -> #{escaped}"
  end
  
  puts "\n=== Identifier Escape Tests ==="
  test_identifiers = [
    "user_name",
    "user name",
    'table"name',
    "",
    nil
  ]
  
  test_identifiers.each do |identifier|
    escaped = escape_identifier(identifier)
    puts "#{identifier.inspect} -> #{escaped}"
  end
  
  puts "\n=== Where Clause Tests ==="
  test_conditions = [
    { name: "John", age: 25 },
    { status: ["active", "pending"] },
    { created_at: Date.new(2023, 1, 1)..Date.new(2023, 12, 31) },
    { deleted_at: nil }
  ]
  
  test_conditions.each do |conditions|
    clause = build_where_clause(conditions)
    puts "#{conditions.inspect} -> #{clause}"
  end
end