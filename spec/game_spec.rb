require 'tennis'

RSpec.describe Tennis::Game do
  let(:game) { Tennis::Game.new }

  context 'when initialized' do
    it 'reports a score of 0-0' do
      expect(game.score).to eq '0-0'
    end
  end
end
