def valid_parentheses(str)
  stack = []
  pairs = { '(' => ')', '[' => ']', '{' => '}' }
  
  str.each_char do |char|
    if pairs.key?(char)
      stack.push(char)
    elsif pairs.value?(char)
      return false if stack.empty?
      return false if pairs[stack.pop] != char
    end
  end
  
  stack.empty?
end