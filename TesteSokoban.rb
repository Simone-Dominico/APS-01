require 'test/unit'
require_relative 'Read'
require_relative 'Moving'
require_relative 'Populate'
require 'minitest/spec'
require 'minitest/autorun'

class TestSokoban < Test::Unit::TestCase

	attr_reader :map, :game	

	def runTest
		r = Read.new
		r.reading
		@game = r.newGame
		
	end

	def test_moving_up
		runTest
		@game.go_up
		@map = []
		
		file = File.open('text_up.txt', 'r') 

        file.each_with_index do |line, index| 
            l = line.split('')
            @map << line
        end  

        file.close 
          
		assert_equal(positionTest,game.position,"O comando está sendo reconhecido!")
	end
	def positionTest

			line = @map.find do |line|
				not line.index('@').nil?
			end

			row = @map.index(line)
			col = line.index '@'

			{:row => row, :col => col}
	end

	def test_moving_left
		runTest
		@game.go_left
		@map = []
		
		file = File.open('text_left.txt', 'r') 

        file.each_with_index do |line, index| 
            l = line.split('')
            @map << line
        end  

        file.close 
          
		assert_equal(positionTest,game.position,"O comando está incorreto!")
	end


end