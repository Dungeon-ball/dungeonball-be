require 'rails_helper'

RSpec.describe Player do
  describe 'relationships' do
    it { should have_many :party_players }
    it { should have_many(:parties).through(:party_players) }
  end

  describe 'class methods' do
    it '.to_dnd(num) converts a num from 0-99 to a num from 8-20' do
      expect(Player.to_dnd(85)).to eq 17
      expect(Player.to_dnd(90)).to eq 18
      expect(Player.to_dnd(95)).to eq 19
      expect(Player.to_dnd(99)).to eq 20
    end
  end

  describe 'instance methods' do
    before :each do
      @player = Player.create!(
        name: 'billy',
        position: 'QB',
        age: 30,
        speed: 80,
        agility: 90,
        acceleration: 78,
        awareness: 70,
        strength: 76,
        toughness: 88
      )
    end

    it 'uses ".to_dnd" for Strength, Constitution, and Intelligence' do
      expect(@player.strength).to eq Player.to_dnd(76)
      expect(@player.constitution).to eq Player.to_dnd(88)
      expect(@player.intelligence).to eq Player.to_dnd(70)
    end

    it 'uses ".to_dnd" on the average of speed, accel, and agility for Dexterity' do
      avg = (@player.agility + @player.speed + @player.acceleration) / 3

      expect(@player.agility).to eq Player.to_dnd(avg)
    end
  end
end
