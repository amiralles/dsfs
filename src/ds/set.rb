require_relative "singly_linked_list"

module DS
  class Set
    def initialize
      @list = SinglyLinkedList.new
    end

    def insert member
      return if contains? member
      @list.insert member
    end

    def remove member
      node = @list.find_first do |nd|
        nd.data == member
      end
      @list.remove node if node
    end

    def union other
      res = Set.new
      @list.each do |nd|
        res.insert(nd.data)
      end
      other.each do |data|
        res.insert(data)
      end
      res
    end

    def intersect other
      res = Set.new
      @list.each do |nd|
        if other.contains?(nd.data)
          res.insert(nd.data)
        end
      end
      res
    end

    def diff other
      res = Set.new
      @list.each do |nd|
        unless other.contains?(nd.data)
          res.insert(nd.data)
        end
      end
      res
    end

    def contains? member
      @list.find_first do |nd|
        nd.data == member
      end
    end

    def subset? other
      if self.count > other.count
        return false
      end
      @list.each do |nd|
        unless other.contains?(nd.data)
          return false
        end
      end
      true
    end

    def equal? other
      if self.count != other.count
        return false
      end
      subset? other
    end

    def count
      @list.length
    end

    def each
      return nil unless block_given?

      current = @list.head
      while current
        yield current&.data
        current = current.next
      end
    end

    def print
      @list.print
    end
  end
end
