require_relative "node"

module DS
  class Stack
    def initialize
      @head   = nil
      @tail   = nil
      @length = 0
    end

    def push data
      node = Node.new data
      if @length == 0
        @tail = node
      end
      node.next = @head
      @head = node
      @length += 1
    end

    def pop
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
        pop
      end
    end

    def print
      if @length == 0
        puts "empty"
      else
        current = @head
        while current
          puts current.data
          current = current.next
        end
      end
    end
  end
end
