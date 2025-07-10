class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

def binary_tree_inorder(root)
  result = []
  inorder_helper(root, result)
  result
end

def inorder_helper(node, result)
  return if node.nil?
  
  inorder_helper(node.left, result)
  result << node.val
  inorder_helper(node.right, result)
end

def create_sample_tree
  root = TreeNode.new(1)
  root.left = TreeNode.new(2)
  root.right = TreeNode.new(3)
  root.left.left = TreeNode.new(4)
  root.left.right = TreeNode.new(5)
  root
end

if __FILE__ == $0
  tree = create_sample_tree
  puts "Inorder traversal: #{binary_tree_inorder(tree)}"
end