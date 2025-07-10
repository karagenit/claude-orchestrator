class Stack
  def initialize
    @items = []
  end

  def push(item)
    @items.push(item)
  end

  def pop
    return nil if empty?
    @items.pop
  end

  def top
    return nil if empty?
    @items.last
  end

  def empty?
    @items.empty?
  end

  def size
    @items.length
  end

  def to_array
    @items.dup
  end
end

def stack_implementation
  stack = Stack.new
  
  stack.push(1)
  stack.push(2)
  stack.push(3)
  
  puts "Stack after pushing 1, 2, 3: #{stack.to_array}"
  puts "Top element: #{stack.top}"
  puts "Size: #{stack.size}"
  
  popped = stack.pop
  puts "Popped: #{popped}"
  puts "Stack after pop: #{stack.to_array}"
  puts "New top: #{stack.top}"
  puts "Is empty: #{stack.empty?}"
  
  stack
end

if __FILE__ == $0
  stack_implementation
end