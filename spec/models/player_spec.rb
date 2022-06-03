require 'rails_helper'

RSpec.describe Player do
  describe 'relationships' do
    it { should have_many :player_parties }
    it { should have_many(:parties).through(:player_parties) }
  end
end