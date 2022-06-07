class Api::V1::Party::PlayersController < ApplicationController

  def create
    party = Party.create!(party_params) unless party = Party.find_by(user_id: party_params[:user_id])
    PartyPlayer.create!(party_player_params) unless PartyPlayer.where(party_id: party.id, player_id: params[:player_id]).length != 0
    render json: {"error": "Under Development"}, status: 200
  end

private

  def party_params
    {
      user_id: params[:user_id],
      name: "default_name"
    }
  end

  def party_player_params
    {
      player_id: params[:player_id],
      party_id: Party.find_by(user_id: params[:user_id]).id
    }
  end

end
