require 'minitest/autorun'
require_relative 'bst_node'

# https://stackoverflow.com/questions/2603692/what-is-the-difference-between-tree-depth-and-height

class BinarySearchTreeTest < MiniTest::Test
  def setup
  end

  def test_bst_distance
    nodes = [5,6,3,1,2,4]
    root = BstNode.build_tree(nodes)
    
    assert_equal 3, root.distance(2,4)

    root = BstNode.build_tree([50, 60, 30, 10, 20, 40])
    assert_equal 4, root.distance(20,60)
  end

  def test_bst_size
    nodes = [5,6,3,1,2,4]
    root = BstNode.build_tree(nodes)
    assert_equal 6, root.size
  end

  def test_bst_path
    nodes = [5,6,3,1,2,4]
    root = BstNode.build_tree(nodes)
    assert_equal [5], root.path(5).map {|n| n.value}
    assert_equal 0, root.depth(5)
    
    assert_equal [5,6], root.path(6).map {|n| n.value}
    assert_equal 1, root.depth(6)
    
    assert_equal [5,3,1,2], root.path(2).map {|n| n.value}
    assert_equal 3, root.depth(2)
    
    assert_equal [5,3,4], root.path(4).map {|n| n.value}
    assert_equal 2, root.depth(4)
  end

end
