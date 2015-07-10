class Api::RoutesController < ApplicationController
  respond_to :xml, :json
  def create
    map = Map.find_or_initialize_by(name: params[:map])
    map.routes.build routes_params
    map.save!
    map.places.create(name: params[:origin]) unless map.places.find_by(name: params[:origin])
    map.places.create(name: params[:destination]) unless map.places.find_by(name: params[:destination])

    render json: "Criado com sucesso"

  end

  def index
    @maps = Map.all
  end

  private
  def routes_params
    params.permit(:origin, :destination, :distance)
  end

end
