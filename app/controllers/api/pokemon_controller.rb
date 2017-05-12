class Api::PokemonController < ApplicationController
  def index
    @pokemons = Pokemon.all.includes(:items)
    render :index
  end

  def show
    @pokemon = Pokemon.includes(:items).find(params[:id])
    render :show
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      render json: @pokemon
    else
      render json: @pokemon.errors.full_messages, status: 422
    end
  end

  private
  def pokemon_params
    params.require(:pokemon).permit(:name, :attack, :defense, :poke_type, :image_url, moves: [])
  end
end
