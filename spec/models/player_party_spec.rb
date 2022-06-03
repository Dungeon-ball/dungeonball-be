require 'rails_helper'

RSpec.describe PlayerParty do
  describe 'relationships' do
    it { should belong_to :player }
    it { should belong_to :party } 
  end
end
