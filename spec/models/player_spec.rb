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

    it '.to_dnd(num) just returns 8 if the number is less than 41' do
      expect(Player.to_dnd(40)).to eq 8
      expect(Player.to_dnd(2)).to eq 8
    end

    it '.to_dnd(num) just returns 20 if num is greater than 99' do
      expect(Player.to_dnd(100)).to eq 20
      expect(Player.to_dnd(5000)).to eq 20
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

    it 'returns age / 3 for wisdom' do
      expect(@player.wisdom).to eq(@player.age / 3)
    end

    it 'uses ".to_dnd" for dnd_Strength, Constitution, and Intelligence' do
      expect(@player.dnd_strength).to eq Player.to_dnd(76)
      expect(@player.constitution).to eq Player.to_dnd(88)
      expect(@player.intelligence).to eq Player.to_dnd(70)
    end

    it 'uses ".to_dnd" on the average of speed, accel, and agility for Dexterity' do
      avg = (@player.agility + @player.speed + @player.acceleration) / 3

      expect(@player.dexterity).to eq Player.to_dnd(avg)
    end

    describe 'using .dnd_class' do
      it 'QB are Wizards' do
        player = create(:player, position: 'QB')
        expect(player.dnd_class).to eq 'Wizard'
      end

      it 'MLB are Clerics' do
        player = create(:player, position: 'MLB')
        expect(player.dnd_class).to eq 'Cleric'
      end

      it 'K and P are Rangers' do
        player1 = create(:player, position: 'K')
        player2 = create(:player, position: 'P')
        expect(player1.dnd_class).to eq 'Ranger'
        expect(player2.dnd_class).to eq 'Ranger'
      end

      it 'HB and FB are Sorcerers' do
        player1 = create(:player, position: 'HB')
        player2 = create(:player, position: 'FB')
        expect(player1.dnd_class).to eq 'Sorcerer'
        expect(player2.dnd_class).to eq 'Sorcerer'
      end

      it 'LG and RG are Barbarians' do
        player1 = create(:player, position: 'LG')
        player2 = create(:player, position: 'RG')
        expect(player1.dnd_class).to eq 'Barbarian'
        expect(player2.dnd_class).to eq 'Barbarian'
      end

      it 'ROLB and LOLB are Paladins' do
        player1 = create(:player, position: 'ROLB')
        player2 = create(:player, position: 'LOLB')
        expect(player1.dnd_class).to eq 'Paladin'
        expect(player2.dnd_class).to eq 'Paladin'
      end

      it 'LT, C, and RT are Fighters' do
        player1 = create(:player, position: 'LT')
        player2 = create(:player, position: 'C')
        player3 = create(:player, position: 'RT')
        expect(player1.dnd_class).to eq 'Fighter'
        expect(player2.dnd_class).to eq 'Fighter'
        expect(player3.dnd_class).to eq 'Fighter'
      end

      it 'DT, CB, SS, and FS are Rogue' do
        player1 = create(:player, position: 'DT')
        player2 = create(:player, position: 'CB')
        player3 = create(:player, position: 'SS')
        player4 = create(:player, position: 'FS')
        expect(player1.dnd_class).to eq 'Rogue'
        expect(player2.dnd_class).to eq 'Rogue'
        expect(player3.dnd_class).to eq 'Rogue'
        expect(player4.dnd_class).to eq 'Rogue'
      end

      it 'WR, TE, LE, RE are Monks' do
        player1 = create(:player, position: 'WR')
        player2 = create(:player, position: 'TE')
        player3 = create(:player, position: 'LE')
        player4 = create(:player, position: 'RE')
        expect(player1.dnd_class).to eq 'Monk'
        expect(player2.dnd_class).to eq 'Monk'
        expect(player3.dnd_class).to eq 'Monk'
        expect(player4.dnd_class).to eq 'Monk'
      end
    end
  end
end
