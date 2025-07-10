class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

def binary_tree_height(root)
  return 0 if root.nil?
  
  left_height = binary_tree_height(root.left)
  right_height = binary_tree_height(root.right)
  
  [left_height, right_height].max + 1
end

def create_sample_tree
  root = TreeNode.new(3)
  root.left = TreeNode.new(9)
  root.right = TreeNode.new(20)
  root.right.left = TreeNode.new(15)
  root.right.right = TreeNode.new(7)
  root
end

if __FILE__ == $0
  tree = create_sample_tree
  puts "Tree height: #{binary_tree_height(tree)}"
  puts "Empty tree height: #{binary_tree_height(nil)}"
end