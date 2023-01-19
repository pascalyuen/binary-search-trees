# frozen_string_literal: true

require_relative 'tree'
require_relative 'node'

tree = Tree.new(Array.new(15) { rand(1..100) })
puts tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"
# Unbalance the tree by adding several numbers > 100
tree.insert(120)
tree.insert(140)
tree.insert(160)
puts tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"
# Balance the tree by calling #rebalance
tree = tree.rebalance
puts tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"
# Print out all elements in level, pre, post, and in order
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"
