require_relative '../ds/hash_table'
require 'test/unit'

class HashTableFixture < Test::Unit::TestCase
  include DS

  def test_init_hash_table
    ht = HashTable.new
    assert ht.size == 0
  end


  def test_add_entry
    ht = HashTable.new
    ht.upsert("foo", "bar")

    assert ht.get("foo") == "bar"
  end

  def test_update_entry
    ht = HashTable.new
    ht.upsert("foo", "bar")
    ht.upsert("foo", "baz")

    assert ht.get("foo") == "baz"
  end

  def test_delete_entry
    ht = HashTable.new
    ht.upsert("foo", "bar")
    ht.delete("foo")

    assert ht.get("foo").nil?
  end

  def test_rebuild_table
    ht = HashTable.new
    # add a bunch of keys to trigger
    # the rebuild process.
    ht.upsert("key1", 1);
    ht.upsert("key2", 2);
    ht.upsert("key3", 3);
    ht.upsert("key4", 4);
    ht.upsert("key5", 5);
    ht.upsert("key6", 6);
    ht.upsert("key7", 7);
    ht.upsert("key8", 8);
    ht.upsert("key9", 9);
    ht.upsert("key10", 10);
    ht.upsert("key11", 11);

    assert ht.get("key11") == 11
  end

end
