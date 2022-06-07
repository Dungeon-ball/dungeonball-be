require 'rails_helper'

RSpec.describe DndClass do
  it 'can be initialized with JSON from the dnd api' do
    response = File.read('spec/fixtures/dnd_monk_response.json')
    json = JSON.parse(response, symbolize_names: true)

    result = DndClass.new(json)

    expect(result).to be_a DndClass

    expect(result.name).to eq('Monk')
    expect(result.hitpoints).to be 8

    expect(result.proficiencies).to be_a Array
    expect(result.proficiencies).to be_all String
    expect(result.proficiencies.count).to eq 4

    expect(result.proficiencies).to include 'Saving Throw: DEX'
    expect(result.proficiencies).to include 'Saving Throw: STR'
    expect(result.proficiencies).to include 'Shortswords'
    expect(result.proficiencies).to include 'Simple Weapons'
  end
end
