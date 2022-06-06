require 'rails_helper'

RSpec.describe DndClass do
  it 'can be initialized with JSON from the dnd api' do
    response = File.read('spec/fixtures/dnd_monk_response.json')
    json = JSON.parse(response.body, symbolize_names: true)

    result = DndClass.new(json)

    expect(result).to be_a DndClass

    expect(result.name).to eq('Monk')
    expect(result.hitpoints <= 8).to be true

    expect(result.proficiencies).to be_a Array
    expect(result.proficiencies).to be_all String
    expect(result.proficiencies.count).to eq 2

    expect(result.proficiencies[0]).to eq 'Shortswords'
    expect(result.proficiencies[1]).to eq 'Simple Weapons'
  end
end
