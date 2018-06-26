require_relative './game'

module Tennis
  # A tennis match consists of one set, each consisting of many games.
  class Match
    # Create a new match with two named players.
    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
    end

    # Award a point to the named player.
    # Note: This mutates the object.
    def point_won_by(player)
      puts "Point won by #{player}" # TODO
    end

    # Return the current score as a string.
    def score
      '0-0, 0-0'
    end
  end
end
