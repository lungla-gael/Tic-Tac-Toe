class Player 
    attr_reader :name, :character
    attr_accessor :position, :patterns

    def initialize(name,character)
        @name = name
        @character = character.upcase      
        @patterns = {"a1b1c1"=>0,"a1a2a3"=>0,"b1b2b3"=>0,"c1c2c3"=>0,
                    "a1b2c3"=>0,"a2b2c2"=>0,"a3b3c3"=>0,"c1b2a3"=>0}
        @position = ""
    end

    def won?
        patterns.each { |pattern,count| patterns[pattern] += 1 if pattern.include?(position) }
        patterns.values.any?(3)? true : false
    end

    def to_default
        patterns.each{ |pattern,count| patterns[pattern] = 0}
    end

    def to_s
        "#{name} has chosen #{character}"
    end
end