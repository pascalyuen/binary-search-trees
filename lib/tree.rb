# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_reader :root

  def initialize(array)
    @sorted_array = array.sort.uniq
    @root = build_tree(@sorted_array)
  end

  def build_tree(array)
    return nil unless array.length > 0

    mid = array.length/2

    root = Node.new(array[mid])
    root.left = build_tree(array[...mid])
    root.right = build_tree(array[mid + 1...])
    root
  end

  def insert(value, root = @root)
    return Node.new(value) if root.nil?

    if value < root.data
      root.left = insert(value, root.left)
    else
      root.right = insert(value, root.right)
    end
    root
  end

  def delete(value, root = @root)
    # Base case: the value cannot be found
    return nil if root.nil?

    # Search for the root
    if value < root.data
      root.left = delete(value, root.left)
    elsif value > root.data
      root.right = delete(value, root.right)
    else
      # The root is found (value == root.data)
      # The root has zero or one child
      return root.right if root.left.nil?
      return root.left if root.right.nil?
      # The root has two children
      root.data = findMin(root.right)
      root.right = delete(root.data, root.right)
    end
    root
  end

  def findMin(root = @root)
    min = root.data
    while(!root.left.nil?)
      min = root.left.data
      root = root.left
    end
    min
  end

  # Write a #find method which accepts a value and returns the node with the given value
  def find(value, root = @root)
    return root if root.nil? || root.data == value

    if value < root.data
      find(value, root.left)
    elsif value > root.data
      find(value, root.right)
    end
  end

  def level_order
    return if @root.nil?

    queue = [@root]
    output = []

    until queue.empty?
      current_node = queue.shift
      if block_given?
        yield current_node
      else
        output << current_node.data
      end
      queue << current_node.left unless current_node.left.nil?
      queue << current_node.right unless current_node.right.nil?
    end
  output unless block_given?
  end

  # LDR
  def inorder(root = @root, array = [], &block)
    return if root.nil?

    inorder(root.left, array, &block)
    if block_given?
      yield root
    else
      array << root.data
    end
    inorder(root.right, array, &block)
    array unless block_given?
  end

  # DLR
  def preorder(root = @root, array = [], &block)
    return if root.nil?

    if block_given?
      yield root
    else
      array << root.data
    end
    preorder(root.left, array, &block)
    preorder(root.right, array, &block)
    array unless block_given?
  end

  # LRD
  def postorder(root = @root, array = [], &block)
    return if root.nil?

    postorder(root.left, array, &block)
    postorder(root.right, array, &block)
    if block_given?
      yield root
    else
      array << root.data
    end
    array unless block_given?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.insert(2)
tree.delete(2)
puts tree.pretty_print
puts "The node with value 1 is #{tree.find(1)}"
p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder
