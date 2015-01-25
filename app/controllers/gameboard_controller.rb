class GameboardController < ApplicationController 
 def index 
  @card = Card.find(3)
 end 
end