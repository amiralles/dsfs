require_relative '../ds/stack'
require 'test/unit'

class StackFixture < Test::Unit::TestCase
  include DS

  def test_init_empty_stack
    s = Stack.new
    assert s.size == 0
  end

  def test_push_items
    s = Stack.new
    s.push "foo"
    s.push "bar"
    assert s.size == 2
  end

  def test_peek_item
    s = Stack.new
    s.push "foo"
    s.push "bar"

    assert s.peek.data == "bar"
  end

  def test_peek_item_on_empty_stack
    s = Stack.new
    assert s.peek.nil?
  end

  def test_pop_items
    s = Stack.new
    s.push "foo"
    s.push "bar"
    s.push "baz"

    s.pop
    s.pop

    assert s.peek.data == "foo"
    assert s.size == 1
  end

  def test_pop_from_empty_stack
    s = Stack.new
    s.pop
    assert s.size == 0
  end

  def test_clear
    s = Stack.new
    s.push "foo"
    s.push "bar"
    s.push "baz"

    s.clear
    assert s.size == 0
  end

  def test_print
    s = Stack.new
    s.push "foo"
    s.push "bar"
    s.push "baz"

    s.print
  end
end

