require_relative './scoring'

module Tennis
  class Game < Scoring
    WIN_MINIMUM = 4
    TIE_BREAK_WIN_MINIMUM = 7

    # Start a new game, which may be a tie-break game. The player names are
    # required to format the score in the case of an Advantage.
    def initialize(player1, player2, tie_break: false)
      super(win_minimum: tie_break ? TIE_BREAK_WIN_MINIMUM : WIN_MINIMUM)

      @player1 = player1
      @player2 = player2
      @tie_break = tie_break
    end

    def tie_break?
      @tie_break
    end

    # Override the default score formatting.
    def score
      return super if tie_break? || won?
      return 'Deuce' if deuce?

      case advantage
      when 1 then "Advantage #{player1}"
      when 2 then "Advantage #{player2}"
      else game_score
      end
    end

    private

    attr_reader :player1, :player2

    def game_score
      translate_points(score1) + '-' + translate_points(score2)
    end

    def translate_points(points)
      case points
      when 1 then '15'
      when 2 then '30'
      when 3 then '40'
      else points.to_s
      end
    end
  end
end
