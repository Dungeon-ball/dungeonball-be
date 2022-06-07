class PartyPlayerController < ApplicationController

  def create
    party = Party.create!(party_params) unless party = Party.find_by(user_id: party_params[:user_id])
    PartyPlayers.create!(party_player_params)
  end

private

  def party_params
    params.require(:user_id).include(name: "default_name")
  end

  def party_player_params
    params.require(:user_id, :party_id)
  end

end
