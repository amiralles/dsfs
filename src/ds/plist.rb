require_relative "singly_linked_list"

module DS
  # This patched version of SinglyLinkedList
  # allows us to reuse some nodes while 
  # working with immutable lists.
  class SinglyLinkedList
    # Reuses nodes from the target node
    # to the end of the list.
    def reuse_from_node node
      self.tail.next = node
      len = 1
      tmp = node
      while tmp = tmp.next
        len += 1
      end
      # *len* is the distance from the 
      # target node to EOL.
      self.length += len
    end

    def insert data
      node = PList::Node.new data
      unless head
        self.head = node
      else
        self.tail.next = node
      end
      self.tail = node
      self.length += 1
    end
  end

  class PList
    class Node
      attr_accessor :data

      def initialize data
        self.data = data
        self.data.freeze
      end

      def next=(node)
        @next = node
      end

      def next
        @next
      end

      def to_s
        self.data&.to_s || "nil"
      end
    end

    def self.empty
      list = SinglyLinkedList.new
      list.freeze
    end

    def self.insert list, data
      ret = self.copy list
      ret.insert data
      ret.freeze
    end

    def self.update list, node, data
      ret   = SinglyLinkedList.new
      reuse = false
      found = false
      list.each do |nd|
        unless found
          found = (nd.data == node.data)
          if found
            ret.insert(data)
            reuse = true
            next
          end
        end
        unless reuse
          ret.insert(data)
        else
          # Reuse nodes from target to tail.
          ret.reuse_from_node(nd)
          break
        end
      end
      ret.freeze
    end

    def self.remove list, node
      ret   = SinglyLinkedList.new
      reuse = false
      found = false
      list.each do |nd|
        unless found
          found = (nd.data == node.data)
          if found
            reuse = true
            next # skip the target node.
          end
        end
        unless reuse
          ret.insert(nd.data)
        else
          # Reuse nodes from target to tail.
          ret.reuse_from_node(nd)
          break
        end
      end
      ret.freeze
    end

    def self.cat lhs, rhs
      ret = self.copy lhs
      ret.cat rhs
      ret.freeze
    end

    def self.len list
      list&.length || 0
    end

    def self.contains? list, data
    find_first list do |nd|
      if (nd.data == data)
        return true
      end
    end
    end

    def self.find_first list, &predicate
      return nil unless list
      return list.find_first &predicate
    end

    def self.each list, &block
      return nil unless list
      list.each &block
    end

    def self.print list
      unless list
        print "empty"
      else
        list.print
      end
    end

    private
    def self.copy src
      dst = SinglyLinkedList.new
      src.each do |node|
        dst.insert node.data
      end
      dst
    end
  end
end
