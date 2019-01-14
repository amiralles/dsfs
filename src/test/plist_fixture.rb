require_relative '../ds/plist'
require 'test/unit'

class PersistentListFixture < Test::Unit::TestCase
  include DS

  def test_empty_list
    l = PList.empty
    assert PList.len(l) == 0
  end

  def test_insert
    l1 = PList.insert PList.empty, "foo"
    l2 = PList.insert l1, "bar"

    # Both versions can coexist.
    assert PList.len(l1) == 1
    assert PList.len(l2) == 2
    assert PList.contains?(l1, "foo")
    assert PList.contains?(l2, "foo")
    assert PList.contains?(l2, "bar")
  end

  def test_update
    l1 = PList.insert PList.empty, "foo"
    foo   = PList.find_first l1 do |nd|
      nd.data == "foo"
    end

    l2 = PList.update l1, foo, "bar"

    # l1 still has "foo"
    assert PList.contains?(l1, "foo")
    assert !PList.contains?(l2, "foo")
  end

  def test_remove
    l1 = PList.insert PList.empty, "foo"
    foo   = PList.find_first l1 do |nd|
      nd.data == "foo"
    end

    l2 = PList.remove l1, foo

    # l1 still has "foo"
    assert PList.contains?(l1, "foo")
    assert !PList.contains?(l2, "foo")
  end


  def test_cat
    l1 = PList.insert PList.empty, "foo"
    l2 = PList.insert PList.empty, "bar"
    l3 = PList.cat l1, l2

    assert PList.contains?(l3, "foo")
    assert PList.contains?(l3, "bar")
  end

  def test_each
    l1 = PList.insert PList.empty, 1
    l2 = PList.insert l1, 2
    l3 = PList.insert l2, 3

    sum = 0
    PList.each l3 do |nd|
      sum += nd.data
    end

    assert(sum == 6)
  end

end
