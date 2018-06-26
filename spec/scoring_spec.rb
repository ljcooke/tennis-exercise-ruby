require 'tennis'

RSpec.describe Tennis::Scoring do
  let(:scoring) { Tennis::Scoring.new(win_minimum: 4, win_margin: 2) }

  context 'when initialized' do
    it 'reports a score of 0-0' do
      expect(scoring.score).to eq '0-0'
    end
  end

  context 'when the score is incremented' do
    it 'reports the appropriate score for both players' do
      scoring.increment(player: 1)
      expect(scoring.score).to eq '1-0'
      scoring.increment(player: 1)
      expect(scoring.score).to eq '2-0'
      scoring.increment(player: 2)
      expect(scoring.score).to eq '2-1'
    end
  end

  context 'when both scores have reached the minimum for a deuce' do
    before(:example) do
      3.times { scoring.increment(player: 1) }
      3.times { scoring.increment(player: 2) }
    end

    context 'and the scores are equal' do
      it 'reports a deuce' do
        expect(scoring.deuce?).to be true
        expect(scoring.advantage).to be nil
      end
    end

    context 'and a player is ahead by one point' do
      it 'reports advantage for the player' do
        scoring.increment(player: 1)
        expect(scoring.deuce?).to be false
        expect(scoring.advantage).to eq 1

        2.times { scoring.increment(player: 2) }
        expect(scoring.deuce?).to be false
        expect(scoring.advantage).to eq 2
      end
    end
  end

  context 'when a player has reached the minimum to win' do
    before(:example) do
      4.times { scoring.increment(player: 1) }
      2.times { scoring.increment(player: 2) }
    end

    context 'and the player is ahead by a winning margin' do
      it 'reports a win for the player' do
        expect(scoring.won?).to be true
        expect(scoring.winner).to eq 1
      end
    end

    context 'and the player is below the winning margin' do
      before(:example) do
        scoring.increment(player: 2)
      end

      it 'does not report a win' do
        expect(scoring.won?).to be false
        expect(scoring.winner).to be nil
      end
    end
  end

  context 'when a player is ahead by a winning margin' do
    context 'below the minimum to win' do
      before(:example) do
        3.times { scoring.increment(player: 1) }
        1.times { scoring.increment(player: 2) }
      end

      it 'does not report a win' do
        expect(scoring.won?).to be false
        expect(scoring.winner).to be nil
      end
    end
  end
end
