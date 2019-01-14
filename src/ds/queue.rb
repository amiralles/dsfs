require_relative "node"

module DS
  class Queue
    def initialize
      @head   = nil
      @tail   = nil
      @length = 0
    end

    def enqueue data
      node = Node.new data
      unless @head
        @head = node
      else
        @tail.next = node
      end
      @tail    = node
      @length += 1
    end

    def dequeue
      return nil unless @length > 0
      @head = @head.next
      @tail = nil if @length == 1
      @length -= 1
    end

    def peek
      @head
    end

    def size
      @length
    end

    def clear
      while peek
        dequeue
      end
    end

    def each
      return nil unless block_given?
      current = @head
      while current
        yield current
        current = current.next
      end
    end

    def print
      if @length == 0
        puts "empty"
      else
        each do |node|
          puts node.data
        end
      end
    end
  end
end
