class Populate

	attr_reader :game, :goals

	def initialize(game)
		@game = game
	end

	def populate_goals
			@goals = []
			
			
			@game.each_with_index do |line,row|
				col = 0
				line.each_char do |char| 
					if (char == '.')
						@goals << {:row => row, :col => col}
					end
					col+=1
				end
			end
		end
	def goals
		@goals
	end

end