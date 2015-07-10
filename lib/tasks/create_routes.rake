namespace :create_routes do
  desc 'Criando rotas primarias'
  task :start => :environment do
    # hash para população previa do banco de dados

    routes = [
      {
        origin: "A",
        destination: "B",
        distance: 10.0
      },
      {
        origin: "B",
        destination: "D",
        distance: 15.0
      },
      {
        origin: "A",
        destination: "C",
        distance: 20.0
      },
      {
        origin: "C",
        destination: "D",
        distance: 30.0
      },
      {
        origin: "B",
        destination: "E",
        distance: 50.0
      },
      {
        origin: "D",
        destination: "E",
        distance: 30.0
      }
    ]

    mapa = "Sao Paulo"

    map = Map.create(name: mapa)
    routes.each do |r|
      Route.create(origin: r[:origin], destination: r[:destination], distance: r[:distance], map_id: map.id )
      map.places.create(name: r[:origin]) unless map.places.find_by(name: r[:origin])
      map.places.create(name: r[:destination]) unless map.places.find_by(name: r[:destination])
    end


    puts "Rotas criadas com sucesso!!!"
  end

end
