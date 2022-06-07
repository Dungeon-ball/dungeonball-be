class DndService
  def self.get_class_data(name)
    response = conn.get("/api/classes/#{name.downcase}")

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://www.dnd5eapi.co')
  end
end
