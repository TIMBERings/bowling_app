require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#score_game' do
    it 'can score a perfect game' do
      game = Game.create(
        score: nil,
        frames: [
          FactoryGirl.create(:frame, frame: 1, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 2, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 3, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 4, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 5, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 6, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 7, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 8, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 9, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 10, first: 10, second: nil, score: nil, split: false),
          FactoryGirl.create(:frame, frame: 11, first: 10, second: nil, score: nil, split: false),
          FactoryGirl.create(:frame, frame: 12, first: 10, second: nil, score: nil, split: false)
        ]
      )
      game.finalize_game
      expect(game.score).to eq 300
    end

    it 'can score a 0 game' do
      game = Game.create(
        score: nil,
        frames: [
          FactoryGirl.create(:frame, frame: 1, first: 0, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 2, first: 0, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 3, first: 0, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 4, first: 0, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 5, first: 0, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 6, first: 0, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 7, first: 0, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 8, first: 0, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 9, first: 0, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 10, first: 0, second: 0,  score: nil, split: false)
        ]
      )
      game.finalize_game
      expect(game.score).to eq 0
    end

    it 'can score a markless game' do
      game = Game.create(
        score: nil,
        frames: [
          FactoryGirl.create(:frame, frame: 1, first: 0, second: 9,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 2, first: 1, second: 8,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 3, first: 2, second: 7,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 4, first: 3, second: 6,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 5, first: 4, second: 5,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 6, first: 5, second: 4,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 7, first: 6, second: 3,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 8, first: 7, second: 2,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 9, first: 8, second: 1,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 10, first: 9, second: 0,  score: nil, split: false)
        ]
      )
      game.finalize_game
      expect(game.score).to eq 90
    end

    it 'can score a dutch game' do
      game = Game.create(
        score: nil,
        frames: [
          FactoryGirl.create(:frame, frame: 1, first: 1, second: 9,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 2, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 3, first: 1, second: 9,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 4, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 5, first: 1, second: 9,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 6, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 7, first: 1, second: 9,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 8, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 9, first: 1, second: 9,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 10, first: 10, second: nil, score: nil, split: false),
          FactoryGirl.create(:frame, frame: 11, first: 1, second: 9, score: nil, split: false)
        ]
      )
      game.finalize_game
      expect(game.score).to eq 200
    end

    it 'can score a general game' do
      game = Game.create(
        score: nil,
        frames: [
          FactoryGirl.create(:frame, frame: 1, first: 8, second: 2,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 2, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 3, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 4, first: 9, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 5, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 6, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 7, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 8, first: 8, second: 1,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 9, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 10, first: 10, second: nil, score: nil, split: false),
          FactoryGirl.create(:frame, frame: 11, first: 9, second: 1, score: nil, split: false)
        ]
      )
      game.finalize_game
      expect(game.score).to eq 212
    end
  end

  describe '#finalize_game' do
    it 'scores each frame of a game' do
      game = Game.create(
        score: nil,
        frames: [
          FactoryGirl.create(:frame, frame: 1, first: 8, second: 2,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 2, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 3, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 4, first: 9, second: 0,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 5, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 6, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 7, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 8, first: 8, second: 1,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 9, first: 10, second: nil,  score: nil, split: false),
          FactoryGirl.create(:frame, frame: 10, first: 10, second: nil, score: nil, split: false),
          FactoryGirl.create(:frame, frame: 11, first: 9, second: 1, score: nil, split: false)
        ]
      )
      game.finalize_game
      scores = game.frames.collect(&:score)

      expect(scores).to eq [20, 49, 68, 77, 107, 135, 154, 163, 192, 212, nil]
    end
  end
end
