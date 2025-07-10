class Queue
  def initialize
    @items = []
  end

  def enqueue(item)
    @items.push(item)
  end

  def dequeue
    return nil if empty?
    @items.shift
  end

  def front
    return nil if empty?
    @items.first
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

def queue_implementation
  queue = Queue.new
  
  queue.enqueue(1)
  queue.enqueue(2)
  queue.enqueue(3)
  
  puts "Queue after enqueuing 1, 2, 3: #{queue.to_array}"
  puts "Front element: #{queue.front}"
  puts "Size: #{queue.size}"
  
  dequeued = queue.dequeue
  puts "Dequeued: #{dequeued}"
  puts "Queue after dequeue: #{queue.to_array}"
  puts "New front: #{queue.front}"
  puts "Is empty: #{queue.empty?}"
  
  queue
end

if __FILE__ == $0
  queue_implementation
end