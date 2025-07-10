def tree_traversal(root)
  return [] if root.nil?
  
  result = {
    inorder: [],
    preorder: [],
    postorder: []
  }
  
  def inorder(node, result)
    return if node.nil?
    
    inorder(node.left, result)
    result[:inorder] << node.value
    inorder(node.right, result)
  end
  
  def preorder(node, result)
    return if node.nil?
    
    result[:preorder] << node.value
    preorder(node.left, result)
    preorder(node.right, result)
  end
  
  def postorder(node, result)
    return if node.nil?
    
    postorder(node.left, result)
    postorder(node.right, result)
    result[:postorder] << node.value
  end
  
  inorder(root, result)
  preorder(root, result)
  postorder(root, result)
  
  result
end

class TreeNode
  attr_accessor :value, :left, :right
  
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end