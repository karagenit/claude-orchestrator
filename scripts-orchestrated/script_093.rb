def expression_evaluator(expression)
  return nil if expression.nil? || expression.strip.empty?
  
  expression = expression.gsub(/\s+/, '')
  
  return evaluate_expression(expression)
end

def evaluate_expression(expr)
  return evaluate_addition_subtraction(expr)
end

def evaluate_addition_subtraction(expr)
  result = evaluate_multiplication_division(expr)
  
  while expr.include?('+') || expr.include?('-')
    if expr.include?('+')
      pos = expr.index('+')
      left = expr[0...pos]
      right = expr[pos + 1..-1]
      
      left_val = evaluate_multiplication_division(left)
      right_val = evaluate_addition_subtraction(right)
      
      return left_val + right_val
    elsif expr.include?('-')
      pos = expr.rindex('-')
      left = expr[0...pos]
      right = expr[pos + 1..-1]
      
      left_val = evaluate_multiplication_division(left)
      right_val = evaluate_addition_subtraction(right)
      
      return left_val - right_val
    end
  end
  
  result
end

def evaluate_multiplication_division(expr)
  return expr.to_f if expr.match?(/^\d+\.?\d*$/)
  
  if expr.include?('*')
    pos = expr.index('*')
    left = expr[0...pos]
    right = expr[pos + 1..-1]
    
    return evaluate_multiplication_division(left) * evaluate_multiplication_division(right)
  elsif expr.include?('/')
    pos = expr.index('/')
    left = expr[0...pos]
    right = expr[pos + 1..-1]
    
    return evaluate_multiplication_division(left) / evaluate_multiplication_division(right)
  end
  
  expr.to_f
end