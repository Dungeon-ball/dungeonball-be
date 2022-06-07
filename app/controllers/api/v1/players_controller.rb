class Api::V1::PlayersController < ApplicationController
  def index
    @players = PlayerFacade.find_by_name(params[:name])

    if @players
      render json: PlayerSerializer.players_index(@players)
    else
      render json: { error: 'too many matches. Please make your query more specific' }, status: 400
    end
  end
end
