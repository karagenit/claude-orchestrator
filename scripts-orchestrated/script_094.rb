def rpn_calculator(expression)
  return nil if expression.nil? || expression.strip.empty?
  
  tokens = expression.split
  stack = []
  
  tokens.each do |token|
    case token
    when '+'
      return nil if stack.size < 2
      b = stack.pop
      a = stack.pop
      stack.push(a + b)
    when '-'
      return nil if stack.size < 2
      b = stack.pop
      a = stack.pop
      stack.push(a - b)
    when '*'
      return nil if stack.size < 2
      b = stack.pop
      a = stack.pop
      stack.push(a * b)
    when '/'
      return nil if stack.size < 2
      b = stack.pop
      a = stack.pop
      return nil if b == 0
      stack.push(a / b)
    else
      if is_number?(token)
        stack.push(token.to_f)
      else
        return nil
      end
    end
  end
  
  stack.size == 1 ? stack.first : nil
end

def is_number?(str)
  str.match?(/^-?\d+\.?\d*$/)
end