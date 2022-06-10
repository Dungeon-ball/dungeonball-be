class Api::V1::PartiesController < ApplicationController
  def show
    party = ::Party.find_or_create_by(user_id: params[:user_id])

    render json: Api::V1::Party::PlayersController::PartyPlayerSerializer.party_player_show(party.players, party, params[:user_id])
  end
end
