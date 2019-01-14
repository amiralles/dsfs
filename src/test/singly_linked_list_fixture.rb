require_relative '../ds/singly_linked_list'
require 'test/unit'

class SinglyLinkedListFixture < Test::Unit::TestCase
  include DS

  def test_initialize
    list = SinglyLinkedList.new
    assert list.length == 0
  end

  def test_insert_items
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"

    assert list.length == 2
    assert list.includes?("foo")
    assert list.includes?("bar")
  end

  def test_remove_item
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"
    target = list.find_first do |nd|
      nd.data == "foo"
    end

    list.remove target

    present = list.includes?("foo")
    assert !present
  end

  def test_remove_middle_item
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"
    list.insert "baz"

    target = list.find_first do |nd|
      nd.data == "bar"
    end

    list.remove target

    present = list.includes?("bar")
    assert !present
    assert list.length == 2
  end

  def test_remove_last_item
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"
    list.insert "baz"

    target = list.find_first do |nd|
      nd.data == "baz"
    end

    list.remove target

    present = list.includes?("baz")
    assert !present
    assert list.length == 2
  end


  def test_remove_item_twice
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"

    target = list.find_first do |nd|
      nd.data == "foo"
    end

    list.remove target # <- Removes "foo".
    list.remove target # <- Does nothing.

    assert list.length == 1
  end

  def test_remove_missing_item
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"

    target = Node.new "missing"

    # Remove ignores missing nodes.
    list.remove target

    assert list.length == 2
  end

  def test_remove_from_empty_list
    list = SinglyLinkedList.new
    target = Node.new "missing"
    # Remove ignores missing nodes.
    list.remove target
    assert list.length == 0
  end


  def test_concat_list
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"

    other = SinglyLinkedList.new
    other.insert "baz"

    list.cat other

    assert list.length == 3
    assert list.includes?("foo")
    assert list.includes?("bar")
    assert list.includes?("baz")
  end

  def test_concat_empty_lists
    list  = SinglyLinkedList.new
    other = SinglyLinkedList.new
    list.cat other

    assert list.length == 0
  end

  def test_concat_empty_to_non_empty
    list  = SinglyLinkedList.new
    other = SinglyLinkedList.new
    other.insert "foo"

    list.cat other
    assert list.length == 1
  end

  def test_clear
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"
    list.clear

    assert list.length == 0
  end

  def test_clear_empty_list
    list = SinglyLinkedList.new
    list.clear

    assert list.length == 0
  end

  def test_find_items
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"

    foo = list.find_first do |nd| 
      nd.data == "foo"
    end

    bar = list.find_first do |nd| 
      nd.data == "bar"
    end

    assert foo
    assert bar
  end

  def test_find_missing_item
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"
    item = list.find_first do |nd| 
      nd.data == "missing"
    end

    assert item.nil?
  end

  def test_find_item_on_empty_list
    list = SinglyLinkedList.new
    item = list.find_first do |nd| 
      nd.data == "missing"
    end

    assert item.nil?
  end

  def test_includes
    list = SinglyLinkedList.new
    list.insert "foo"

    assert list.includes?("foo")
  end

  def test_includes_missing_item
    list = SinglyLinkedList.new
    list.insert "foo"

    present = list.includes?("bar")
    assert !present
  end

  def test_includes_on_empty_list
    list = SinglyLinkedList.new
    assert !(list.includes?("foo"))
  end

  def test_each_yields_all_items
    list = SinglyLinkedList.new
    list.insert "foo"
    list.insert "bar"
    list.insert "baz"

    sum  = 0
    list.each do |nd| 
      sum += 1
    end

    assert sum == list.length
  end

  def test_each_on_empty_list
    list = SinglyLinkedList.new
    sum  = 0
    list.each do |nd| 
      sum += 1
    end
    assert sum == list.length
  end
end

