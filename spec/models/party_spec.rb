require 'rails_helper'

RSpec.describe Party do
  describe 'relationships' do
    it { should have_many :party_players } 
    it { should have_many(:players).through(:party_players) }
  end
end
