class Api::V1::PlayersController < ApplicationController
  def index
    @players = PlayerFacade.find_by_name(params[:name])

    render json: PlayerSerializer.players_index(@players)
  end
end
