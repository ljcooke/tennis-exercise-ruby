require_relative './set'

module Tennis
  # A tennis match consists of one set, each consisting of many games.
  class Match
    # Create a new match with two named players.
    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
      @active_set = Tennis::Set.new(player1, player2)
    end

    # Award a point to the named player.
    # Note: This mutates the object.
    def point_won_by(player)
      case player
      when player1 then active_set.increment(player: 1)
      when player2 then active_set.increment(player: 2)
      end
    end

    # Return the score of the set.
    def score
      active_set.score
    end

    private

    attr_accessor :player1, :player2
    attr_accessor :active_set
  end
end
