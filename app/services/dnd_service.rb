class DndService
  def self.get_class_data(name)
    response = conn.get("/classes/#{name}")

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://www.dnd5eapi.co/api')
  end
end
