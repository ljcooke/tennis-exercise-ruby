require 'tennis'

RSpec.describe Tennis::Match do
  let(:player1) { 'player 1' }
  let(:player2) { 'player 2' }
  let(:match) { Tennis::Match.new(player1, player2) }

  context 'when initialized' do
    it 'reports a score of 0-0' do
      expect(match.score).to eq '0-0'
    end
  end

  context 'with the example match provided' do
    it 'returns the expected score at each step' do
      match.point_won_by(player1)
      match.point_won_by(player2)
      expect(match.score).to eq '0-0, 15-15'

      match.point_won_by(player1)
      match.point_won_by(player1)
      expect(match.score).to eq '0-0, 40-15'

      match.point_won_by(player2)
      match.point_won_by(player2)
      expect(match.score).to eq '0-0, Deuce'

      match.point_won_by(player1)
      expect(match.score).to eq '0-0, Advantage player 1'

      match.point_won_by(player1)
      expect(match.score).to eq '1-0'
    end
  end
end
