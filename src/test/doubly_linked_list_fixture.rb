require_relative '../ds/doubly_linked_list'
require 'test/unit'

class DoublyLinkedListFixture < Test::Unit::TestCase
  include DS

  def test_initialize
    list = DoublyLinkedList.new
    assert list.length == 0
  end

  def test_insert_items
    list = DoublyLinkedList.new
    list.insert "foo"
    list.insert "bar"

    assert list.length == 2
    assert list.includes?("foo")
    assert list.includes?("bar")
  end

  def test_remove_item
    list = DoublyLinkedList.new
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
    list = DoublyLinkedList.new
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
    list = DoublyLinkedList.new
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

  def test_remove_from_empty_list
    list = DoublyLinkedList.new
    node = DoublyLinkedList::Node.new ""
    # Remove ignores missing nodes.
    list.remove node
    assert list.length == 0
  end

  def test_concat_list
    list = DoublyLinkedList.new
    list.insert "foo"
    list.insert "bar"

    other = DoublyLinkedList.new
    other.insert "baz"

    list.cat other

    assert list.length == 3
    assert list.includes?("foo")
    assert list.includes?("bar")
    assert list.includes?("baz")
  end

  def test_concat_empty_lists
    list  = DoublyLinkedList.new
    other = DoublyLinkedList.new
    list.cat other

    assert list.length == 0
  end

  def test_concat_empty_to_non_empty
    list  = DoublyLinkedList.new
    other = DoublyLinkedList.new
    other.insert "foo"
    other.insert "bar"

    list.cat other
    assert list.length == 2
  end

  def test_clear
    list = DoublyLinkedList.new
    list.insert "foo"
    list.insert "bar"
    list.clear

    assert list.length == 0
  end

  def test_find_items
    list = DoublyLinkedList.new
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
    list = DoublyLinkedList.new
    item = list.find_first do |nd| 
      nd.data == "missing"
    end

    assert item.nil?
  end

  def test_find_last_item
    list = DoublyLinkedList.new
    list.insert "foo"
    list.insert "bar"

    foo = list.find_last do |nd| 
      nd.data == "foo"
    end

    assert foo
  end

  def test_find_last_missing_item
    list = DoublyLinkedList.new
    item = list.find_first do |nd| 
      nd.data == "missing"
    end

    assert item.nil?
  end

  def test_find_first_on_empty_list
    list = DoublyLinkedList.new
    item = list.find_first do |nd| 
      nd.data == "missing"
    end

    assert item.nil?
  end

  def test_find_last_on_empty_list
    list = DoublyLinkedList.new
    item = list.find_last do |nd| 
      nd.data == "missing"
    end

    assert item.nil?
  end

  def test_includes
    list = DoublyLinkedList.new
    list.insert "foo"

    assert list.includes?("foo")
  end

  def test_includes_missing_item
    list = DoublyLinkedList.new
    list.insert "foo"

    present = list.includes?("bar")
    assert !present
  end

  def test_includes_on_empty_list
    list = DoublyLinkedList.new
    assert !(list.includes?("foo"))
  end

  def test_each_yields_all_items
    list = DoublyLinkedList.new
    sum  = 0
    list.each do |nd| 
      sum += 1
    end

    assert sum == list.length
  end

  def test_reverse_each_yields_all_items
    list = DoublyLinkedList.new
    list.insert "foo"
    list.insert "bar"
    list.insert "baz"

    sum  = 0
    list.reverse_each do |nd| 
      sum += 1
    end

    assert sum == list.length
  end

  def test_reverse_each_on_empty_list
    list = DoublyLinkedList.new
    sum  = 0
    list.reverse_each do |nd| 
      sum += 1
    end

    assert sum == list.length
  end
end

