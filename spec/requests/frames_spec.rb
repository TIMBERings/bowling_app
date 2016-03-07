require 'rails_helper'

RSpec.describe "Frames", type: :request do
  describe "GET games/1/frames" do
    let(:game) { FactoryGirl.create :game }
    it "works! (now write some real specs)" do
      get game_frames_path(game_id: game.id)
      expect(response).to have_http_status(200)
    end
  end
end
