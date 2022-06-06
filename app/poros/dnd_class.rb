class DndClass
  attr_reader :name, :hitpoints, :proficiencies

  def initialize(data)
    @name = data[:name]
    @hitpoints = data[:hit_die]
    @proficiencies = grab_proficiencies(data)
  end

  def grab_proficiencies(data)
    profs = []

    data[:proficiencies].each { |prof| profs << prof[:name] }
    data[:saving_throws].each { |prof| profs << "Saving Throw: #{prof[:name]}" }

    profs
  end
end
