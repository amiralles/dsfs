require_relative '../ds/queue'
require 'test/unit'

class QueueFixture < Test::Unit::TestCase
  include DS

  def test_init_empty_queue
    q = Queue.new
    assert q.size == 0
  end

  def test_enqueue_items
    q = Queue.new
    q.enqueue "foo"
    q.enqueue "bar"
    assert q.size == 2
  end

  def test_peek_item
    q = Queue.new
    q.enqueue "foo"
    q.enqueue "bar"

    assert q.peek.data == "foo"
  end

  def test_peek_item_on_empty_queue
    q = Queue.new
    assert q.peek.nil?
  end

  def test_dequeue_items
    q = Queue.new
    q.enqueue "foo"
    q.enqueue "bar"
    q.enqueue "baz"

    q.dequeue
    q.dequeue

    assert q.peek.data == "baz"
    assert q.size == 1
  end

  def test_dequeue_from_empty_queue
    q = Queue.new
    q.dequeue
    assert q.size == 0
  end

  def test_clear
    q = Queue.new
    q.enqueue "foo"
    q.enqueue "bar"
    q.enqueue "baz"

    q.clear
    assert q.size == 0
  end

  def test_each
    q = Queue.new
    q.enqueue "foo"
    q.enqueue "bar"
    q.enqueue "baz"

    sum = 0
    q.each do |nd|
      sum += 1
    end
    assert sum == 3
  end

  def test_each_on_empty_queue
    q = Queue.new
    sum = 0
    q.each do |nd|
      sum += 1
    end
    assert sum == 0
  end
end

