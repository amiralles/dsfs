require_relative '../ds/graph'
require 'test/unit'

class GraphFixture < Test::Unit::TestCase
  include DS

  def test_insert_vertex
    g = Graph.new
    g.insert_vertex "foo"

    assert g.find_vertex("foo")
  end

  def test_remove_vertex
    g = Graph.new
    g.insert_vertex "foo"
    g.remove_vertex "foo"

    assert !g.find_vertex("foo")
  end

  def test_insert_edge
    g = Graph.new
    g.insert_vertex "foo"
    g.insert_vertex "bar"

    g.insert_edge "foo", "bar"

    assert g.adjacent?("foo", "bar")
  end

  def test_remove_edge
    g = Graph.new
    g.insert_vertex "foo"
    g.insert_vertex "bar"

    g.insert_edge "foo", "bar"
    g.remove_edge "foo", "bar"

    assert !g.adjacent?("foo", "bar")
  end
end

