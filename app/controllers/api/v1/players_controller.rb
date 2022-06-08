class Api::V1::PlayersController < ApplicationController
  def index
    @players = PlayerFacade.find_by_name(params[:name])

    if @players
      render json: PlayerSerializer.players_index(@players)
    else
      render json: { error: 'too many matches. Please make your query more specific' }, status: 400
    end
  end

  def show
    @player = PlayerFacade.find_by_id(params[:id])
    #@player = Player.find(params[:id])

    if @player
      render json: PlayerSerializer.players_show(@player)
    else
      render json: { error: 'Player not found' }, status: 400
    end
  end
end
