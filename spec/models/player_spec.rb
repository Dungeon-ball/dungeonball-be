require 'rails_helper'

RSpec.describe Player do
  describe 'relationships' do
    it { should have_many :party_players }
    it { should have_many(:parties).through(:party_players) }
  end
end
