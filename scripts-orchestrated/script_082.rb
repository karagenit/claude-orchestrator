class PriorityQueue
  def initialize
    @heap = []
  end

  def push(element, priority)
    @heap << [priority, element]
    bubble_up(@heap.length - 1)
  end

  def pop
    return nil if @heap.empty?
    
    if @heap.length == 1
      @heap.pop
    else
      top = @heap[0]
      @heap[0] = @heap.pop
      bubble_down(0)
      top
    end
  end

  def peek
    @heap.empty? ? nil : @heap[0]
  end

  def empty?
    @heap.empty?
  end

  def size
    @heap.length
  end

  private

  def bubble_up(index)
    return if index == 0
    
    parent_index = (index - 1) / 2
    if @heap[index][0] < @heap[parent_index][0]
      @heap[index], @heap[parent_index] = @heap[parent_index], @heap[index]
      bubble_up(parent_index)
    end
  end

  def bubble_down(index)
    left_child = 2 * index + 1
    right_child = 2 * index + 2
    smallest = index

    if left_child < @heap.length && @heap[left_child][0] < @heap[smallest][0]
      smallest = left_child
    end

    if right_child < @heap.length && @heap[right_child][0] < @heap[smallest][0]
      smallest = right_child
    end

    if smallest != index
      @heap[index], @heap[smallest] = @heap[smallest], @heap[index]
      bubble_down(smallest)
    end
  end
end

def priority_queue
  pq = PriorityQueue.new
  
  pq.push("task1", 3)
  pq.push("task2", 1)
  pq.push("task3", 2)
  pq.push("task4", 1)
  
  puts "Processing tasks by priority:"
  while !pq.empty?
    priority, task = pq.pop
    puts "#{task} (priority: #{priority})"
  end
  
  pq
end