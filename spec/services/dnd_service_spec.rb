require 'rails_helper'

RSpec.describe DndService do
  context 'class methods' do
    it '.get_class_data returns class info as JSON' do
      result = DndService.get_class_data('Monk')

      expect(result).to be_a Hash

      expect(result).to have_key :name
      expect(result[:name]).to be_a String

      expect(result).to have_key :hit_die
      expect(result[:hit_die]).to eq 8

      expect(result).to have_key :proficiencies
      expect(result[:proficiencies]).to be_an Array
      expect(result[:proficiencies]).to be_all Hash

      result[:proficiencies].each do |prof|
        expect(prof).to have_key :name
        expect(prof[:name]).to be_a String
      end

      expect(result).to have_key [:saving_throws]
      expect(result[:saving_throws]).to be_a Array
      expect(result[:saving_throws]).to be_all Hash

      result[:saving_throws].each do |prof|
        expect(prof).to have_key :name
        expect(prof[:name]).to be_a String
      end
    end
  end
end
