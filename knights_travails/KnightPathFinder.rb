require_relative '00_tree_node_copy.rb'
require "byebug"

class KnightPathFinder
attr_reader :root_node

    def initialize(pos) #pos is an array like [2,1]
        @root_node = PolyTreeNode.new(pos) #need to updated PolyTreeNode to accept pos
        @initial_pos = @root_node.clone #.clone to avoid changing @root_node in the future
        @move_tree = []
        @considered_positions = [@initial_pos]
    end

    #what is self?
    #why is this a class method

    def self.valid_moves(pos) #returns array of possible valid moves
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

    def new_move_positions(pos) #returns array 
        moves = KnightPathFinder.valid_moves(pos)
        moves.reject! do |position|
            @considered_positions.include?(position)
        end
        moves
    end

    def build_move_tree
        # moves = [@root_node]
        # 
    end

    def find_path(final_pos) #returns array of all positions necessary to take the shortest possible path final_pos from @initial_pos
        
        # keep checking node children until moves.include?(final_pos)
    end


end



