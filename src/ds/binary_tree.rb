require_relative "node"

module DS
  class BinaryTree
    class Node
      attr_accessor :parent, :data,
        :left, :right

      def initialize parent, data
        self.parent = parent
        self.data   = data
      end

      def to_s
        puts self.data
        puts self.left
        puts self.right
      end
    end

    def initialize root
      @root = root
      @size = 1
    end

    def root
      @root
    end

    def size
      @size
    end

    def size=(s)
      @size = s
    end

    def insert_left(node, data)
      return unless node
      if node.left
        raise "Can't override nodes."
      end
      @size += 1
      node.left = Node.new node, data
    end

    def insert_right(node, data)
      return unless node
      if node.right
        raise "Can't override nodes."
      end
      @size += 1
      node.right = Node.new node, data
    end

    def remove_left(node)
      if node&.left
        remove_left(node.left)
        remove_right(node.left)
        node.left = nil
        @size -= 1
      end
    end

    def remove_right(node)
      if node&.right
        remove_left node.right
        remove_right node.right
        node.right = nil
        @size -= 1
      end
    end

    def self.merge tree1, tree2, data = nil
      unless tree1 && tree2
        raise "Can't merge nil trees."
      end

      root = Node.new(nil, data);
      res  = BinaryTree.new root

      res.root.left  = tree1.root
      res.root.right = tree2.root

      res.size = tree1.size + tree2.size
      res
    end

    def print
      print_rec @root
    end

    private
    def print_rec node, indent=0
      print_node node, indent
      if node&.left
        print_rec node.left, indent + 1
      end
      if node&.right
        print_rec node.right, indent + 1
      end
    end

    def print_node node, indent
      data = node&.data&.to_s || "nil"
      puts data.rjust indent * 4, " "
    end
  end
end
