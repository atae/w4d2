class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def create
    @cat = Cat.new(cat_params)
		if @cat.save
			redirect_to cats_url
		else
			render :new
		end
  end

  def new
    @cat = Cat.new(name:"",birth_date:Date.today,color:nil,sex:"",description:nil)
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cats_url
    else
      render :edit
		end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
  end
end
