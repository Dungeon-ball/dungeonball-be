class Api::V1::Party::PlayersController < ApplicationController

  before_action :logged_in?, :validate_fe

  def create
    # Request Validations
    if !params.keys.include?("player_id")
      render json: { "error": "a valid player_id parameter is required for this request"}, status: 400
    elsif (params["player_id"] =~ /\A\d+\Z/) == nil
      # Regex tests that "player_id" matches a string of numerals from start to end, and nothing else
      render json: { "error": "player_id does not match the expected format"}, status: 400
    elsif !Player.exists?(params["player_id"])
      render json: { "error": "player_id provided was not found"}, status: 400
    else
      # Database Action
      party = ::Party.create!(party_params) unless party = ::Party.find_by(user_id: party_params[:user_id])
      PartyPlayer.create!(party_player_params) unless PartyPlayer.where(party_id: party.id, player_id: params[:player_id]).length != 0
      # Responds with success even if no actions taken...?
      render json: PartyPlayerSerializer.player_party_create_response(party.players, party, params[:user_id]), status: 200
    end
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

  def logged_in?
      render json: { "error": "user must be logged in to use this endpoint" }, status: 401 unless params[:user_id] =~ /\d+/
  end

end
