require_relative 'Moving'

class Read
    attr_reader :nivel

    def initialize
        @nivel = []
    end

    #--Leitura--#
    def reading
        file = File.open('level_01.txt', 'r') 

        file.each_with_index do |line, index| 
            l = line.split('')
            @nivel << line
        end  

        file.close  
    end
    #----#

    def newGame
        Moving.new(@nivel)
    end
    #--Comando--#
    def command
        game = newGame
        puts game.actual

        while true do
            #pegar o que vem do teclado
            cmd = STDIN.gets    

            case cmd
            when "w\n" then game.go_up
            when "s\n" then game.go_down
            when "a\n" then game.go_left
            when "d\n" then game.go_right

            end

            #para limpar a tela e reescrever
            system("clear")
            puts game.actual
            if game.is_win == true
                puts "Parabéns, você venceu!!"
                break
            end
        end
    end
    #----#
end