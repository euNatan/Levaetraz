class WelcomeController < ActionController::Base
  layout "application"

  def index
    @maps = Map.all
  end

  def create_route
     map = Map.find_or_initialize_by(name: params[:map])
     map.routes.build routes_params
     map.save!
     map.places.create(name: params[:origin]) unless map.places.find_by(name: params[:origin])
     map.places.create(name: params[:destination]) unless map.places.find_by(name: params[:destination])


     redirect_to :root, notice: "Rota criada com sucesso"
  end

  def route
    @maps = Map.all
  end

  def places
    @map = Map.find(params[:map])
    render layout: false
  end

  def route_show
    res = Map.find(params[:map]).routes.where("origin = ? and destination = ? || destination = ? and origin = ?", params[:origin], params[:destination] , params[:origin], params[:destination] ).first
    if res.present?
      @km = res.distance
      @cost = (res.distance / params[:km_l].to_f) * params[:price].to_f
      @origin = params[:origin]
      @midi = ""
      @destination = params[:destination]


      render layout: false
      return
    end

    origin  = Map.find(params[:map]).routes.where("origin = ? or destination = ?", params[:origin], params[:origin] )
    destination  = Map.find(params[:map]).routes.where("origin = ? or destination = ?", params[:destination], params[:destination] )

    result_a = []
    result_b = []

    value_a = []
    value_b = []

    origin.each do |place|
      if place.origin.include? params[:origin]
        result_a << { "A" => { to: place.origin, from: place.destination, distance: place.distance} }
      else
        result_a << { "A" => { to: place.destination, from: place.origin, distance: place.distance} }
      end
    end

    destination.each do |place|
      if place.origin.include? params[:destination]
        result_b << { "B" => { to: place.origin, from: place.destination, distance: place.distance} }
      else
        result_b << { "B" => { to: place.destination, from: place.origin, distance: place.distance} }
      end
    end
    result_a.each do |orig|
     result_b.each do |dest|

       if orig["A"][:from] == dest["B"][:from]
         value_a << orig
         value_b << dest
       end
     end


    end

     a = value_a.sort_by { |h| h[:distance] }[0]
     b = value_b.sort_by { |h| h[:distance] }[0]
     @km = a["A"][:distance] + b["B"][:distance]
     @cost = ( @km / params[:km_l].to_f) * params[:price].to_f
     @origin = a["A"][:to]
     @midi = a["A"][:from]
     @destination = b["B"][:to]


    render layout: false
  end

  private
  def routes_params
    params.permit(:origin, :destination, :distance)
  end


end
