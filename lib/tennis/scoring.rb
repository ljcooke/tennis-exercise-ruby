module Tennis
  # Shared scoring logic for sets and games.
  # Players are referred to by integers 1 and 2.
  class Scoring
    DEFAULT_WIN_MARGIN = 2

    attr_reader :score1, :score2

    # A player wins if their score is at least `win_minimum` and is greater than
    # the opponent's score by at least `win_margin`.
    def initialize(win_minimum:, win_margin: DEFAULT_WIN_MARGIN)
      @score1 = 0
      @score2 = 0
      @win_minimum = win_minimum
      @win_margin = win_margin
      @deuce_minimum = win_minimum - 1
    end

    def increment(player:)
      case player
      when 1 then @score1 += 1
      when 2 then @score2 += 1
      end
    end

    # Whether the set/game is won.
    def won?
      [score1, score2].max >= win_minimum && (score1 - score2).abs >= win_margin
    end

    # The number of the winning player: either 1 or 2, or nil if it hasn't
    # been won yet.
    def winner
      (score1 > score2 ? 1 : 2) if won?
    end

    # Return the score in the format [player 1]-[player 2].
    # If the game is over, return nil.
    def score
      "#{score1}-#{score2}"
    end

    # Whether the score is in a deuce position.
    def deuce?
      score1 == score2 &&
        score1 >= deuce_minimum &&
        score2 >= deuce_minimum
    end

    # Whether one player is in an 'advantage' position.
    def advantage?
      (score1 - score2).abs == 1 &&
        score1 >= deuce_minimum &&
        score2 >= deuce_minimum
    end

    # Return the number of the player with an 'advantage', or nil if none.
    def advantage
      (score1 > score2 ? 1 : 2) if advantage?
    end

    private

    attr_reader :score1, :score2
    attr_reader :win_minimum, :win_margin, :deuce_minimum
  end
end
