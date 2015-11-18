class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index

  end

  def show
    @cat = Cat.find_by_id(params[:id])
    if @cat.nil?
      flash[:errors] << "Couldn't find cat!"
      redirect_to cats_url
    else
      render :show
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.create(cat_params)
    if @cat.save
      render :show
    else
      render json: cat.errors.full_message, status: :unprocessable_entity
      render :new
    end
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
  end

  def update
    @cat = Cat.find_by_id(params[:id])
    @cat.update(cat_params)

    render :show
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
  end
end
