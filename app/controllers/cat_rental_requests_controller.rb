class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all

  end

  def create_table
  end


end
