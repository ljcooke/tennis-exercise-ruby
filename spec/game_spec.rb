require 'tennis'

RSpec.describe Tennis::Game do
  let(:player1) { 'player 1' }
  let(:player2) { 'player 2' }
  let(:tie_break) { false }
  let(:game) { Tennis::Game.new(player1, player2, tie_break: tie_break) }

  context 'when initialized' do
    it 'reports a score of 0-0' do
      expect(game.score).to eq '0-0'
    end
  end

  context 'with a standard game' do
    it 'requires a minimum of 4 to win' do
      3.times { game.increment(player: 1) }
      expect(game.won?).to be false

      game.increment(player: 1)
      expect(game.won?).to be true
      expect(game.score).to be nil
    end

    context 'with 1 point' do
      before(:example) do
        game.increment(player: 1)
      end

      it 'reports a score of 15' do
        expect(game.score).to eq '15-0'
      end
    end

    context 'with 2 points' do
      before(:example) do
        2.times { game.increment(player: 1) }
      end

      it 'reports a score of 30' do
        expect(game.score).to eq '30-0'
      end
    end

    context 'with 3 points' do
      before(:example) do
        3.times { game.increment(player: 1) }
      end

      it 'reports a score of 40' do
        expect(game.score).to eq '40-0'
      end
    end

    context 'with a deuce' do
      before(:example) do
        3.times { game.increment(player: 1) }
        3.times { game.increment(player: 2) }
      end

      it 'reports a deuce score' do
        expect(game.score).to eq 'Deuce'
      end
    end

    context 'with advantage' do
      before(:example) do
        4.times { game.increment(player: 1) }
        3.times { game.increment(player: 2) }
      end

      it 'reports an advantage score to the player' do
        expect(game.score).to eq "Advantage #{player1}"
      end
    end
  end

  context 'with a tie-break game' do
    let(:tie_break) { true }

    it 'reports the score incrementing normally' do
      game.increment(player: 1)
      expect(game.score).to eq '1-0'
      game.increment(player: 1)
      expect(game.score).to eq '2-0'
      game.increment(player: 1)
      expect(game.score).to eq '3-0'
    end

    it 'requires a minimum of 7 to win' do
      6.times { game.increment(player: 1) }
      expect(game.won?).to be false

      game.increment(player: 1)
      expect(game.won?).to be true
      expect(game.score).to be nil
    end
  end
end
