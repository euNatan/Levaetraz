json.mapas @maps.each do |map|
  json.cidade map.name
  json.rotas map.routes do |route|
    json.origem route.origin
    json.destino route.destination
    json.distancia route.distance
  end
end
