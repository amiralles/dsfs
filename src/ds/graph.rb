require_relative "singly_linked_list"
require_relative "set"

module DS
  # This patched version of SinglyLinkedList 
  # allows us to remove vertices in 
  # constant time.
  class SinglyLinkedList
    def remove_next prev_node
      return nil unless self.length > 0

      unless prev_node
        # remove head.
        self.head = self.head.next
      else
        if prev_node.next == prev_node
          self.head = nil
        else
          old = prev_node.next
          prev_node.next = prev_node.next&.next
          if (old == self.head)
            self.head = old.next
          end
        end
      end

      self.length -= 1
    end
  end

  class Graph
    class Vertex
      attr_accessor :key, :edges

      def initialize key
        self.key = key
        self.edges = Set.new
      end

      def to_s
        self.key.to_s
      end
    end

    def initialize
      @vertices = SinglyLinkedList.new
    end

    def find_vertex key
      @vertices.find_first do |v|
        v.data.key == key
      end
    end

    def insert_vertex key
      return if find_vertex key
      vertex = Vertex.new key
      @vertices.insert vertex
    end

    def insert_edge key1, key2
      v1 = find_vertex key1
      return unless v1

      v2 = find_vertex key2
      return unless v2

      v1.data.edges.insert v2.data.key
    end

    def remove_vertex key
      found  = false
      target = nil
      prev   = nil

      @vertices.each do |v|
        if v.data.edges.contains? key
          return
        end
        if v.data.key == key
          found  = true
          target = v.data
        end
        prev = v unless found
      end

      unless found
        return
      end

      unless target.edges.count == 0
        return
      end

      @vertices.remove_next prev
    end

    def remove_edge key1, key2
      vertex = find_vertex(key1)&.data
      return unless vertex
      vertex.edges.remove key2
    end

    def adjacent? key1, key2
      vertex = find_vertex(key1)&.data
      if vertex&.edges.contains? key2
        return true
      end
      return false
    end

    def print
      @vertices.each do |v|
        puts "#{v.data} (vertex)"
        v.data.edges.each do |e|
          puts "    #{e.data} (edge)"
        end
      end
    end
  end
end
