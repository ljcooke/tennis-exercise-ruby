require_relative './game'
require_relative './scoring'

module Tennis
  # A set consists of many games.
  class Set < Scoring
    WIN_MINIMUM = 7

    # Start the first game in the set.
    def initialize(player1, player2)
      super(win_minimum: WIN_MINIMUM)

      @player1 = player1
      @player2 = player2
      @active_game = nil
    end

    # Increment the game score, starting a new game if necessary.
    # If the game is won, increment the set score.
    def increment(player:)
      return if won?

      start_game! if active_game.nil?
      active_game.increment(player: player)

      return unless active_game.won?
      super(player: active_game.winner)
      end_game!
    end

    # Report the set score, followed by the game score if a game is in progress.
    def score
      set_score = super
      game_score = active_game && active_game.score

      game_score ? "#{set_score}, #{game_score}" : set_score
    end

    private

    attr_reader :player1, :player2
    attr_reader :active_game

    def start_game!
      @active_game = Tennis::Game.new(player1, player2, tie_break: deuce?)
    end

    def end_game!
      @active_game = nil
    end
  end
end
