require_relative 'Populate'

class Moving
	attr_reader :game, :goals

		def initialize(game)
			@game = game
			popular
		end

		def popular
			p = Populate.new(@game)
			p.populate_goals
			@goals = p.goals
		end

		def actual
			@game.join('')
			
		end

		def go_left
		   moving_to({:row =>  0, :col => -1})
		end

		def go_right
		   moving_to({:row =>  0, :col =>  1}) 
		end

		def go_up
			moving_to({:row => -1, :col =>  0})
		end

		def go_down
			moving_to({:row =>  1, :col =>  0})
		end

 
		
		def is_wall(row, col)
			@game[row][col].chr == '#'
		end

		def is_crate(row, col)
			@game[row][col].chr == 'o' or @game[row][col].chr == '*' 
		end

		def is_goal(row, col)
			@game[row][col].chr == '.'
		end

		def moving_to(direction)
			@current = position

			next_row = @current[:row]+direction[:row]
			next_col = @current[:col]+direction[:col]

			after_next_row = next_row + direction[:row]
			after_next_col = next_col + direction[:col]

		    if is_crate(next_row,next_col)

		        unless is_wall(after_next_row,after_next_col) or
		        	   is_crate(after_next_row, after_next_col)

		            move_player(next_row,next_col)
		            object = 'o'

		            if (is_goal(after_next_row,after_next_col))
		            	object = '*'
		            end

		            @game[after_next_row][after_next_col]= object
		        end

		    elsif not is_wall(next_row,next_col)
			    move_player(next_row,next_col)
			end
		end
		def position

			line = @game.find do |line|
				not line.index('@').nil? or not line.index('+').nil?
			end

			row = @game.index(line)
			if(line.index('@'))

			   col = line.index '@'
			elsif(line.index('+'))
				col = line.index '+'
			end

			{:row => row, :col => col}
		end
		def move_player(next_row,next_col)
			if(is_goal(next_row,next_col))
		           @game[next_row][next_col]= '+'
		    elsif
			 	@game[next_row][next_col]='@'
			 end

	        found_goal = @goals.find do |g|
				@current[:row] == g[:row] and @current[:col] == g[:col]
			end

		    if found_goal
		    	@game[@current[:row]][@current[:col]]= '.'
		    else
		    	@game[@current[:row]][@current[:col]]=' '
		    end	
		end
		def is_win
		count = 0
		@game.each do |line| 
			line.each_char do |letter|
				if letter == '*'
					count = count + 1
				end
			end
		end
		count == @goals.length
	end

end
