require_relative './scoring'

module Tennis
  class Game < Scoring
    def initialize(tie_break: false)
      super(win_minimum: 4, win_margin: 2)

      @tie_break = false
    end

    def tie_break?
      @tie_break
    end

    private
  end
end
