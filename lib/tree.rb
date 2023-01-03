# frozen_string_literal: true

require_relative 'node'

class Tree
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts tree.pretty_print
