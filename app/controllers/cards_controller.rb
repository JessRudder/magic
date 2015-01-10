class CardsController < ApplicationController
  before_action :set_Card, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @Cards = Card.all
    respond_with(@Cards)
  end

  def show
    respond_with(@Card)
  end

  def new
    @Card = Card.new
    respond_with(@Card)
  end

  def edit
  end

  def create
    @Card = Card.new(Card_params)
    @Card.save
    respond_with(@Card)
  end

  def update
    @Card.update(Card_params)
    respond_with(@Card)
  end

  def destroy
    @Card.destroy
    respond_with(@Card)
  end

  private
    def set_Card
      @Card = Card.find(params[:id])
    end

    def Card_params
      params[:Card]
    end
end
