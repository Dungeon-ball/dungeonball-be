FactoryBot.define do
  factory :player do
    positions = ["RE", "CB", "HB", "QB",
               "WR", "LE", "RG", "TE",
               "MLB", "LOLB", "DT", "LT",
               "RT", "SS", "C", "LG", "FS",
               "ROLB", "K", "FB", "P"]

    position { positions.sample }
    name { Faker::TvShows::Seinfeld.character }
    age { Faker::Number.within(range: 22..45) }
    speed { Faker::Number.within(range: 30..100) }
    agility { Faker::Number.within(range: 30..100) }
    acceleration { Faker::Number.within(range: 30..100) }
    awareness { Faker::Number.within(range: 30..100) }
    strength { Faker::Number.within(range: 30..100) }
    toughness { Faker::Number.within(range: 30..100) }
  end
end
