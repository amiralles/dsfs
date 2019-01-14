require_relative '../ds/set'
require 'test/unit'

class SetFixture < Test::Unit::TestCase
  include DS

  def test_init_empty_set
    s = Set.new
    assert s.count == 0
  end

  def test_insert_member
    s = Set.new
    s.insert "foo"

    assert s.count == 1
  end

  def test_insert_ignore_dupes
    s = Set.new
    s.insert "foo"
    s.insert "foo"
    s.insert "foo"

    assert s.count == 1
  end

  def test_remove
    s = Set.new
    s.insert "foo"
    s.insert "bar"

    s.remove "foo"

    assert s.count == 1
    assert !s.contains?("foo")
  end

  def test_remove_missing_item
    s = Set.new
    s.insert "foo"
    s.remove "bar"

    assert s.count == 1
    assert s.contains?("foo")
  end

  def test_union
    s1 = Set.new
    s1.insert "foo"
    s1.insert "bar"

    s2 = Set.new
    s2.insert "baz"
    s2.insert "buzz"

    u = s1.union(s2)

    assert u.contains?("foo")
    assert u.contains?("bar")
    assert u.contains?("baz")
    assert u.contains?("buzz")
  end

  def test_union_empty_sets
    s1 = Set.new
    s2 = Set.new
    u = s1.union(s2)

    assert u.count == 0
  end

  def test_union_empty
    s1 = Set.new
    s2 = Set.new
    s2.insert "foo"

    u = s1.union(s2)

    assert u.contains?("foo")
    assert u.count == 1
  end

  def test_union_with_empty_set
    s1 = Set.new
    s1.insert "foo"

    s2 = Set.new
    u = s1.union(s2)

    assert u.contains?("foo")
    assert u.count == 1
  end

  def test_intersect
    s1 = Set.new
    s1.insert "foo"
    s1.insert "bar"

    s2 = Set.new
    s2.insert "foo"

    i = s1.intersect(s2)

    assert i.contains?("foo")
    assert i.count == 1
  end

  def test_intersect_empty_sets
    s1 = Set.new
    s2 = Set.new

    i = s1.intersect(s2)
    assert i.count == 0
  end

  def test_intersect_with_empty
    s1 = Set.new
    s1.insert "foo"
    s1.insert "bar"

    s2 = Set.new
    i = s1.intersect(s2)

    assert i.count == 0
  end

  def test_diff
    s1 = Set.new
    s1.insert "foo"
    s1.insert "bar"

    s2 = Set.new
    s2.insert "foo"

    d = s1.diff(s2)

    assert d.contains?("bar")
    assert d.count == 1
  end

  def test_subset
    s1 = Set.new
    s1.insert "foo"
    s1.insert "bar"
    s1.insert "baz"

    s2 = Set.new
    s2.insert "foo"

    assert s2.subset? s1
  end

  def test_is_not_subset
    s1 = Set.new
    s1.insert "foo"
    s1.insert "bar"
    s1.insert "baz"

    s2 = Set.new
    s2.insert "foo"

    assert !(s1.subset?(s2))
  end

  def test_equal
    s1 = Set.new
    s1.insert "foo"
    s1.insert "bar"

    s2 = Set.new
    s2.insert "foo"
    s2.insert "bar"

    assert s1.equal?(s2)
  end

  def test_not_equal
    s1 = Set.new
    s1.insert "foo"
    s1.insert "bar"
    s1.insert "baz"

    s2 = Set.new
    s2.insert "foo"
    s2.insert "bar"

    assert !s1.equal?(s2)
  end

  def test_each
    s1 = Set.new
    s1.insert 1
    s1.insert 2
    s1.insert 3

    sum = 0
    s1.each do |m|
      sum += m
    end
    assert sum == 6
  end
end
