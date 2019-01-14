require_relative '../ds/avl_tree'
require 'test/unit'

class AVLTreeFixture < Test::Unit::TestCase
  include DS

  def test_insert_and_find_keys
    tree = AVLTree.new
    tree.insert 123, "foo"
    tree.insert 456, "bar"
    tree.insert 789, "baz"

    assert tree.search 123 
    assert tree.search 456
    assert tree.search 789
  end

  def test_remove_and_find_keys
    tree = AVLTree.new
    tree.insert 123, "foo"
    tree.insert 456, "bar"

    tree.insert 789, "baz"

    tree.remove 123
    tree.remove 456
    tree.remove 789

    assert !tree.search(123)
    assert !tree.search(456)
    assert !tree.search(789)
  end
end
