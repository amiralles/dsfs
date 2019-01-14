require_relative "node"

module DS
  class CircularLinkedList
    attr_accessor :head, :length, :current

    def initialize
      self.head   = nil
      self.length = 0
    end

    def insert data
      if (self.length == 0)
        return insert_next(nil, data)
      end

      if (self.length == 1)
        return insert_next(self.head, data)
      end

      self.current = head

      i = 0;
      while ((i += 1) < self.length)
        move_next
      end
      return insert_next(self.current, data)
    end

    def insert_next prev, data
      new_node = Node.new data
      if self.length == 0
        self.head = new_node.next = new_node
      else
        new_node.next = prev.next
        prev.next = new_node
      end
      self.length += 1
    end

    def remove node
      return nil unless node
      return nil unless self.length > 0

      if self.head == node
        return remove_next self.head.next
      end

      prev  = nil
      found = false
      # finds the node that precedes the
      # target node.
      full_scan do |nd|
        if (nd == node)
          found = true
          break
        end
        prev = nd
      end

      remove_next prev if found
    end

    def remove_next prev
      return nil unless self.length > 0

      unless prev
        self.head = self.head.next
      else
        if prev.next == prev
          self.head = nil
        else
          old = prev.next
          prev.next = prev.next&.next
          if (old == self.head)
            self.head = old.next
          end
        end
      end

      self.length -= 1
    end

    def clear
      while self.length > 0
        remove self.head
      end
    end

    def move_next
      self.current = self.current&.next
    end

    def includes? data
      return false unless self.length > 0

      self.current = self.head
      loop do
        if current.data == data
          return true
        end
        if move_next == self.head
          return false 
        end
      end
    end

    def full_scan
      return nil unless block_given?
      return nil unless self.length > 0

      self.current = self.head
      loop do
        yield self.current
        break if (move_next == self.head)
      end
    end

    def find_first &predicate
      return nil unless block_given?
      return nil unless self.length > 0

      self.current = self.head
      loop do
        if predicate.call(self.current)
          return self.current
        end
        break if (move_next == self.head)
      end
    end

    def print
      if self.length == 0
        puts "empty"
      else
        self.full_scan do |item|
          puts item.data
        end
      end
    end
  end
end
