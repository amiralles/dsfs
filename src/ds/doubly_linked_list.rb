require_relative "node"
require_relative "singly_linked_list"

module DS
  class DoublyLinkedList < SinglyLinkedList
    class Node < SinglyLinkedList::Node
      attr_accessor :prev
    end

    def insert data
      node = Node.new data

      unless head
        self.head = node
      else
        node.prev = self.tail
        self.tail.next = node
      end

      self.tail = node
      self.length += 1
    end

    def remove node
      return unless node
      return unless self.length > 0

      # This methods assumes that the target
      # node belongs to the list.
      if node == head
        if head.next.nil?
          self.head = self.tail = nil
        else
          self.head = self.head.next
        end
      else
        p = node.prev
        n = node.next
        p&.next = n
        n&.prev = p
      end

      self.length -= 1
    end

    def cat list
      return unless list
      return unless list.length > 0

      if self.tail
        list.head.prev = self.tail
        self.tail.next = list.head
        self.tail      = list.tail
      else
        self.head = list.head
        self.tail = list.tail
      end

      self.length += list.length
    end

    def find_last &predicate
      return unless block_given?
      return unless self.length > 0

      current = self.tail
      while current
        if predicate.call(current)
          return current
        end
        current = current.prev
      end
    end

    def reverse_each
      return unless block_given?
      return unless self.length > 0

      current = self.tail
      while current
        yield current
        current = current.prev
      end
    end

    def reverse_print
      if self.length == 0
        puts "empty"
      else
        self.reverse_each do |node|
          puts node.data
        end
      end
    end
  end
end

