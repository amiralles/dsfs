require_relative '../ds/circular_linked_list'
require 'test/unit'

class CircularLinkedListFixture < Test::Unit::TestCase
  include DS

  def test_initialize
    list = CircularLinkedList.new
    assert list.length == 0
  end

  def test_insert_items
    list = CircularLinkedList.new
    list.insert "foo"
    list.insert "bar"

    assert list.length == 2
    assert list.includes?("foo")
    assert list.includes?("bar")
  end

  def test_insert_next
    list = CircularLinkedList.new
    list.insert "foo"
    list.insert_next list.head, "bar"

    assert list.length == 2
    assert list.includes?("foo")
    assert list.includes?("bar")
    assert list.head.next.data == "bar"
  end

  def test_remove_item
    list = CircularLinkedList.new
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
    list = CircularLinkedList.new
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
    list = CircularLinkedList.new
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
    list = CircularLinkedList.new
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
    list = CircularLinkedList.new
    list.insert "foo"
    list.insert "bar"

    target = Node.new "missing"

    # Remove ignores missing nodes.
    list.remove target

    assert list.length == 2
  end

  def test_remove_only_item
    list = CircularLinkedList.new
    list.insert "foo"

    target = list.find_first do |nd|
      nd.data == "foo"
    end

    list.remove target

    present = list.includes?("foo")
    assert !present
    assert list.length == 0
  end

  def test_remove_from_empty_list
    list = CircularLinkedList.new
    list.remove Node.new ""

    assert list.length == 0
  end

  def test_clear
    list = CircularLinkedList.new
    list.insert "foo"
    list.insert "bar"
    list.clear

    assert list.length == 0
  end

  def test_find_items
    list = CircularLinkedList.new
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
    list = CircularLinkedList.new
    item = list.find_first do |nd| 
      nd.data == "missing"
    end

    assert item.nil?
  end

  def test_includes
    list = CircularLinkedList.new
    list.insert "foo"

    assert list.includes?("foo")
  end

  def test_includes_missing_item
    list = CircularLinkedList.new
    list.insert "foo"

    present = list.includes?("bar")
    assert !present
  end

  def test_full_scan_yields_all_items
    list = CircularLinkedList.new
    list.insert "foo"
    list.insert "bar"
    list.insert "baz"

    sum  = 0
    list.full_scan do |nd| 
      sum += 1
    end

    assert sum == list.length
  end
end

