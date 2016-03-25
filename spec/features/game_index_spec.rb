require "spec_helper"

describe "Game Index", type: :feature, js: true do
  before :each do
    Capybara.current_driver = :selenium
    visit games_path
  end

  xit 'has stuff' do
    click_link 'New Game'
  end
end
