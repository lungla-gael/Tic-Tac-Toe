load 'player.rb'

def display_board(map)
    print " \t 1   \t 2   \t 3 "; print"\n\n"
    print "a \t #{map["a1"]}  | \t #{map["a2"]}  | \t #{map["a3"]} "; print "\n"
    print "     ______________________"; print "\n\n"
    print "b \t #{map["b1"]}  | \t #{map["b2"]}  | \t #{map["b3"]} "; print "\n"
    print "     ______________________"; print "\n\n"
    print "c \t #{map["c1"]}  | \t #{map["c2"]}  | \t #{map["c3"]} "; print "\n\n"
end

player1 = nil
player2 = nil
chosen_characters = []
puts "enter players' names and characters (X/O)"
print "\n"
2.times{ |a|
    print "player #{a+1}'s name : "
    name = gets.chomp
    loop do
        print "character : "
        character = gets.chomp
        unless chosen_characters.include?(character)
            if character.upcase.eql?("X") || character.upcase.eql?("O")
                chosen_characters.push(character)
                a + 1 === 1? player1 = Player.new(name,character) : player2 = Player.new(name,character)
                break       
            end            
        end      
    end
}

ALL_SLOTS = "a1b1c1a2b2c2a3b3c3"
def round(player1,player2)
    player1.to_default
    player2.to_default
    board_map = {}
    board_map["filled"] = 0
    display_board(board_map)
    finish = false
    
    puts "select a slot to mark e.g a1"
    print "\n"
    def play(player,board_map)
        print "#{player.name} mark a slot : "
        slot = gets.chomp
        if ALL_SLOTS.include?(slot)
            if board_map.has_key?(slot)
                puts "OOPS! slot #{slot} is occupied"
                play(player,board_map)   
            else
                board_map[slot] = player.character
                board_map["filled"] += 1
                player.position = slot
                display_board(board_map) 
            end        
        else
            puts "Sorry slot #{slot} does not exist on the board"
            play(player,board_map,)
        end
    end

    def check_winner?(player,board_map)
        play(player,board_map)
        if board_map["filled"].eql?(9)
            puts "\t\t Its a tie! Nobody Wins!" 
            true
        else
            if player.won?
                puts "\t\t #{player.name} Wins!" 
                true
            else
                false
            end
        end        
    end
    
    until finish === true
        finish = check_winner?(player1,board_map)
        break if finish === true
        finish = check_winner?(player2,board_map)
        break if finish === true
    end    
    
end

again = "y"
while again.eql?("y")
    round(player1,player2)
    print "\t you guys wanna play again? y/n : "
    again = gets.chomp
    print "\n"    
end
