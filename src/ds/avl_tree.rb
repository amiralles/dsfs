module DS
  class AVLTree
    class Node
      attr_accessor :key, :data,
        :height, :left, :right, :deleted

      def initialize key, data
        self.key    = key
        self.data   = data
        self.height = 1
      end
    end

    def insert key, data = nil
      return unless key
      ensure_fixnum key
      @root = insert_and_balance(@root, key, data)
    end

    def remove key
      return unless key
      search(key)&.deleted = true
    end

    def search key
      return unless key
      node = search_rec @root, key
      return node unless node&.deleted
    end

    def print
      print_rec @root, 0
    end

    private
    def h node
      node&.height || 0 
    end

    def insert_and_balance node, key, data = nil
      return Node.new key, data unless node

      if (key < node.key)
        node.left = insert_and_balance(node.left, key, data)
      elsif(key > node.key)
        node.right = insert_and_balance(node.right, key, data)
      else
        node.data  = data
        node.deleted = false
      end
      balance(node)
    end

    def balance n
      set_height n
      # *h* is a helper method that 
      # calculates the height of the tree.
      if (h(n.left) - h(n.right) == 2) 
        if (h(n.left.right) > h(n.left.left)) 
          # return rotate_left_right(n.left)
          return rotate_left_right(n)
        end
        return rotate_right(n)
      elsif (h(n.right) - h(n.left) == 2) 
        if (h(n.right.left) > h(n.right.right)) 
          # return rotate_right_left(n.right)
          return rotate_right_left(n)
        end
        return rotate_left(n)
      end
      return n
    end

    def search_rec node, key
      return nil unless node

      if (key < node.key)
        return search_rec(node.left, key)
      end

      if (key > node.key)
        return search_rec(node.right, key)
      end

      return node
    end

    def set_height node
      lh  = h(node&.left)
      rh  = h(node&.right)
      max = lh > rh ? lh : rh
      node.height = 1 + max
    end

    def rotate_right p
      q       = p.left
      p.left  = q.right
      q.right = p
      set_height p
      set_height q
      return q
    end

    def rotate_left p
      q       = p.right
      p.right = q.left
      q.left  = p
      set_height p
      set_height q
      return q
    end

    def rotate_left_right node
      node.left = rotate_left(node.left)
      return rotate_right(node)
    end

    def rotate_right_left node
      node.right = rotate_right(node.right)
      return rotate_left(node)
    end

    def print_rec node, indent
      unless node
        puts "x".rjust(indent * 4, " ")
        return
      end
      puts_key node, indent
      print_rec node.left, indent + 1
      print_rec node.right, indent + 1
    end

    def puts_key node, indent
      txt = node.key.to_s
      if node.deleted
        txt += " (D)"
        puts txt.rjust(indent * 8, " ")
      else
        puts txt.rjust(indent * 4, " ")
      end
    end

    def ensure_fixnum key
      unless key.class == Fixnum
        raise "Can't use objects of type #{key.class} as keys. Use Fixnum instead."
      end
    end
  end
end
