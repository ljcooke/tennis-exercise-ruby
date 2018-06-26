require 'tennis'

RSpec.describe Tennis::Set do
  let(:player1) { 'player 1' }
  let(:player2) { 'player 2' }
  let(:set) { Tennis::Set.new(player1, player2) }

  context 'when initialized' do
    it 'reports a score of 0-0' do
      expect(set.score).to eq '0-0'
    end
  end

  context 'when incrementing the score' do
    before(:example) do
      set.increment(player: 1)
    end

    it 'increments the score for the game, not the set' do
      expect(set.score).to eq '0-0, 15-0'
    end
  end

  context 'after winning a game' do
    before(:example) do
      4.times { set.increment(player: 1) }
    end

    it 'increments the set score' do
      expect(set.score).to eq '1-0'
    end

    it 'starts a new game if the score is incremented again' do
      set.increment(player: 1)
      expect(set.score).to eq '1-0, 15-0'
    end
  end

  context 'if both players win 6 games' do
    before(:example) do
      6.times do
        4.times { set.increment(player: 1) }
        4.times { set.increment(player: 2) }
      end
    end

    it 'starts a tie-break game next' do
      set.increment(player: 1)
      expect(set.score).to eq '6-6, 1-0'
    end
  end

  context 'if one player wins the set' do
    before(:example) do
      (7 * 4).times { set.increment(player: 1) }
    end

    it 'reports the correct set score' do
      expect(set.score).to eq '7-0'
    end

    it 'cannot change the score any further' do
      set.increment(player: 1)
      expect(set.score).to eq '7-0'
    end
  end
end
