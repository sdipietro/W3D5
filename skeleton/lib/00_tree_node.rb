require "byebug"
module Searchable
    #self is a PolyTreeNode instance
    def dfs(target_value)
        # base case - if the current node value is equal to target value argument
            #return the current node
        # recursion
            #call DFS(target_value) on child nodes 
                #if a child node value is == target_value, then return child node
        #return nil

        #base case: 
        return self if self.value == target_value

        #inductive step
        self.children.each do |child|
            child_checked = child.dfs(target_value)
            if child_checked
                return child_checked
            end
        end
        nil
    end

    def bfs(target_value)
        # create emtpy queue array
        # put self in queue array
        # until array is empty...
            # array.shift current node
            # check if it == target_value
                # if it is...
                     # return node
                 # if it isn't...
                      # push it's children into queue
        # return nil
        queue = []
        queue << self
        until queue.empty?
            current_node = queue.shift
            if current_node.value == target_value
                return current_node
            else
                queue += current_node.children
            end
        end
        nil
    end

end

class PolyTreeNode
attr_reader :value, :parent, :children
    include Searchable

    def initialize(val)
        @value = val
        @parent = nil
        @children = []
    end

    def parent=(node)
        # debugger
        if @parent
            self.parent._children.delete(self)
        end
        @parent = node
        self.parent._children << self unless @parent.nil?
        #@parent.children << self
            #whenever instance variable is called, it creates a duplicate??
        self
    end

    def children
        @children.dup
    end

    def _children #"_" signifies mutation
        @children
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        raise if child.parent == nil  
        child.parent = nil
    end
end

