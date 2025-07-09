def format_currency(amount, currency = 'USD', symbol = '$')
  return "#{symbol}0.00" if amount.nil?
  
  formatted = sprintf("%.2f", amount.abs)
  
  integer_part, decimal_part = formatted.split('.')
  
  integer_part = integer_part.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse
  
  result = "#{symbol}#{integer_part}.#{decimal_part}"
  result = "-#{result}" if amount < 0
  
  result
end