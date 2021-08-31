class FollowedStocksController < ApplicationController
  def index
    @followedstocks = FollowedStock.all
  end

  def new
    @followedstock = FollowedStock.new
  end

  def create
    @followedstock = FollowedStock.new(followedstock_params)
    @followedstock.save
    if @followedstock.save
      redirect_to followed_stocks_path(@followedstock)
    else
      render :new
    end
  end

  def show
    @followedstock = FollowedStock.find(params[:id])
  end

  def destroy
    @followedstock = FollowedStock.find(params[:id])
    @followedstock.destroy
    redirect_to followedstocks_path
  end

  private

  def followedstock_params
    params.require(:followedstock).permit(:name)
  end
end
