class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, next_node = nil)
    @val = val
    @next = next_node
  end
end

def linked_list_reverse(head)
  prev = nil
  current = head
  
  while current
    next_node = current.next
    current.next = prev
    prev = current
    current = next_node
  end
  
  prev
end

def print_list(head)
  values = []
  current = head
  
  while current
    values << current.val
    current = current.next
  end
  
  values
end

def create_sample_list
  head = ListNode.new(1)
  head.next = ListNode.new(2)
  head.next.next = ListNode.new(3)
  head.next.next.next = ListNode.new(4)
  head.next.next.next.next = ListNode.new(5)
  head
end

if __FILE__ == $0
  list = create_sample_list
  puts "Original list: #{print_list(list)}"
  
  reversed = linked_list_reverse(list)
  puts "Reversed list: #{print_list(reversed)}"
end