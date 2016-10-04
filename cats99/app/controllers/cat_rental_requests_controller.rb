class CatRentalRequestsController < ApplicationController
  def new
    render :new
  end

  def create
    @rental = CatRentalRequest.new(request_params)

    if @rental.save
      redirect_to cats_url
    else
      render :new
    end
    
  end

  private
  def request_params
    params.require(:rental).permit(:cat_id, :start_date, :end_date)
  end

end
