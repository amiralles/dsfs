require_relative '../ds/binary_tree'
require 'test/unit'

class BinaryTreeFixture < Test::Unit::TestCase
  include DS

  def test_init_binary_tree
    root = BinaryTree::Node.new nil, "foo"
    bt   = BinaryTree.new root

    assert bt
  end

  def test_insert_left
    root = BinaryTree::Node.new nil, "foo"
    bt   = BinaryTree.new root

    bt.insert_left root, "bar"

    assert root.left.data == "bar"
  end

  def test_insert_left_left
    root = BinaryTree::Node.new nil, "foo"
    bt   = BinaryTree.new root

    nd = bt.insert_left(root, "bar")
    nd = bt.insert_left(nd, "baz")

    assert root.left.left.data == "baz"
  end

  def test_insert_left_right
    root = BinaryTree::Node.new nil, "foo"
    bt   = BinaryTree.new root

    nd = bt.insert_left(root, "bar")
    nd = bt.insert_right(nd, "baz")

    assert root.left.right.data == "baz"
  end

  def test_insert_right
    root = BinaryTree::Node.new nil, "foo"
    bt   = BinaryTree.new root

    bt.insert_right root, "bar"

    assert root.right.data == "bar"
  end

  def test_insert_right_left
    root = BinaryTree::Node.new nil, "foo"
    bt   = BinaryTree.new root

    nd = bt.insert_right root, "bar"
    nd = bt.insert_left(nd, "bar")

    assert root.right.left.data == "bar"
  end

  def test_insert_right_right
    root = BinaryTree::Node.new nil, "foo"
    bt   = BinaryTree.new root

    nd = bt.insert_right root, "bar"
    nd = bt.insert_right(nd, "bar")

    assert root.right.right.data == "bar"
  end

  def test_remove_left
    root = BinaryTree::Node.new nil, "foo"
    bt   = BinaryTree.new root

    bt.insert_left root, "bar"
    bt.remove_left root

    assert !root.left
  end

  def test_remove_right
    root = BinaryTree::Node.new nil, "foo"
    bt   = BinaryTree.new root

    bt.insert_right root, "bar"
    bt.remove_right root

    assert !root.right
  end

  def test_merge
    root = BinaryTree::Node.new nil, "foo"
    lhs  = BinaryTree.new root
    lhs.insert_left(root, "bar");

    root = BinaryTree::Node.new nil, "baz"
    rhs  = BinaryTree.new root
    rhs.insert_left(root, "buzz");

    m = BinaryTree.merge(lhs, rhs)

	assert m.root.left.data == "foo"
	assert m.root.left.left.data == "bar"

	assert m.root.right.data == "baz"
	assert m.root.right.left.data == "buzz"
  end
end

