require_relative '00_tree_node_copy.rb'
require "byebug"

class KnightPathFinder
attr_accessor :root_node, :considered_positions

    def initialize(pos) #pos is an array like [2,3]
        @root_node = PolyTreeNode.new(pos) #need to updated PolyTreeNode to accept pos
        @initial_pos = @root_node.value
        @considered_positions = [pos] #array of duples (pos)
    end

    def <<(arr, val)
        arr << val
    end

    def self.valid_moves(pos) #returns array of possible valid moves as array of duples
        #[2,3] <-- example current location
        valid_moves = []
        row, col = pos
        #row = 2
        #col =3

        possible_positions = [
             # row-> down two
            [row - 2, col - 1], #[0,2] col -> down one
            [row - 2, col + 1], #[0,4] col -> up one
            
            # row -> down one
            [row - 1, col - 2], #[1,1] col -> down two
            [row - 1, col + 2],  #[1,5] col -> up two
        
             # row -> up one
            [row + 1, col -2], #[3,1] col -> down two
            [row + 1, col + 2], #[3,5] col -> up two

              #row-> up two 
            [row + 2, col -1], #[4,2] col -> down one
            [row + 2, col + 1] #[4,4]  col -> up one
        ]
       
        
        possible_positions.reject! do |position| 
            rw, cl = position
            rw < 0 || cl < 0 || cl > 7 || rw > 7
        end
        # possible_positions.each do |position|
        # debugger
        #     rw, cl = position
        #     if rw < 0 || cl < 0 || cl > 7 || rw > 7
        #         possible_positions.delete(position)
        #     end
        # end
        possible_positions
    end

    def new_move_positions(pos) #returns array of duples
        moves = KnightPathFinder.valid_moves(pos)
        moves.reject! do |tuple|
            @considered_positions.include?(tuple)
        end
        moves.each do |tuple|
            @considered_positions << tuple
        end
        moves
    end

    def build_move_tree
        queue = [@root_node] 
        until queue.empty?
            current_node = queue.shift
            new_positions = self.new_move_positions(current_node.value)
            new_positions.each do |pos|
                child_node = PolyTreeNode.new(pos)
                current_node.add_child(child_node)
                queue << child_node
            end
        end

    end

    def find_path(final_pos) #returns the node instance containing end_pos
        final_node = @root_node.dfs(final_pos)
        trace_path_back(final_node)
    end

    def trace_path_back(final_node) 
        positions = [final_node.value]
        current_node = final_node
        until current_node == @root_node
            parent_node = current_node.parent
            positions.unshift(parent_node.value)
            current_node = parent_node
        end
        positions
    end

    # kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
    # kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
end

kpf = KnightPathFinder.new([2,3])
kpf.build_move_tree
p kpf.find_path([1, 4]) # => [[2,3],[0,2],[1,4]]
p kpf.find_path([6, 2]) 


