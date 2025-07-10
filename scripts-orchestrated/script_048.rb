def csv_parse(csv_text, options = {})
  return [] if csv_text.nil? || csv_text.empty?
  
  delimiter = options[:delimiter] || ','
  quote_char = options[:quote_char] || '"'
  headers = options[:headers] || false
  skip_blanks = options[:skip_blanks] || false
  
  lines = csv_text.split(/\r?\n/)
  rows = []
  
  lines.each do |line|
    next if skip_blanks && line.strip.empty?
    
    row = parse_csv_line(line, delimiter, quote_char)
    rows << row unless row.nil?
  end
  
  return rows unless headers
  
  return [] if rows.empty?
  
  header_row = rows.shift
  return [] if header_row.nil? || header_row.empty?
  
  rows.map do |row|
    hash = {}
    header_row.each_with_index do |header, index|
      hash[header] = row[index] if header && !header.empty?
    end
    hash
  end
end

def parse_csv_line(line, delimiter, quote_char)
  return [] if line.nil?
  
  fields = []
  current_field = ""
  in_quotes = false
  i = 0
  
  while i < line.length
    char = line[i]
    
    if char == quote_char
      if in_quotes
        if i + 1 < line.length && line[i + 1] == quote_char
          current_field += quote_char
          i += 1
        else
          in_quotes = false
        end
      else
        in_quotes = true
      end
    elsif char == delimiter && !in_quotes
      fields << current_field
      current_field = ""
    else
      current_field += char
    end
    
    i += 1
  end
  
  fields << current_field
  
  fields
end

def csv_generate(data, options = {})
  return "" if data.nil? || data.empty?
  
  delimiter = options[:delimiter] || ','
  quote_char = options[:quote_char] || '"'
  headers = options[:headers] || false
  
  lines = []
  
  if data.first.is_a?(Hash)
    if headers
      header_line = generate_csv_line(data.first.keys, delimiter, quote_char)
      lines << header_line
    end
    
    data.each do |row|
      values = data.first.keys.map { |key| row[key] }
      csv_line = generate_csv_line(values, delimiter, quote_char)
      lines << csv_line
    end
  else
    data.each do |row|
      csv_line = generate_csv_line(row, delimiter, quote_char)
      lines << csv_line
    end
  end
  
  lines.join("\n")
end

def generate_csv_line(fields, delimiter, quote_char)
  return "" if fields.nil? || fields.empty?
  
  escaped_fields = fields.map do |field|
    field_str = field.to_s
    
    needs_quoting = field_str.include?(delimiter) || 
                   field_str.include?(quote_char) || 
                   field_str.include?("\n") || 
                   field_str.include?("\r")
    
    if needs_quoting
      escaped = field_str.gsub(quote_char, quote_char + quote_char)
      "#{quote_char}#{escaped}#{quote_char}"
    else
      field_str
    end
  end
  
  escaped_fields.join(delimiter)
end

if __FILE__ == $0
  test_csv = <<~CSV
    name,age,city
    John,25,New York
    "Jane Doe",30,"Los Angeles"
    Bob,35,"Chicago, IL"
    "Alice ""Wonder"" Smith",28,Boston
  CSV
  
  puts "=== CSV Parse Tests ==="
  puts "Original CSV:"
  puts test_csv
  puts
  
  puts "Parsed without headers:"
  result = csv_parse(test_csv)
  result.each_with_index do |row, i|
    puts "Row #{i}: #{row.inspect}"
  end
  puts
  
  puts "Parsed with headers:"
  result_with_headers = csv_parse(test_csv, headers: true)
  result_with_headers.each_with_index do |row, i|
    puts "Row #{i}: #{row.inspect}"
  end
  puts
  
  puts "=== CSV Generate Tests ==="
  test_data = [
    { name: "John", age: 25, city: "New York" },
    { name: "Jane Doe", age: 30, city: "Los Angeles" },
    { name: 'Bob "The Builder"', age: 35, city: "Chicago, IL" }
  ]
  
  generated = csv_generate(test_data, headers: true)
  puts "Generated CSV:"
  puts generated
end