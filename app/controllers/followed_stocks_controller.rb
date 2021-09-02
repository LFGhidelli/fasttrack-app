class FollowedStocksController < ApplicationController
  def index
    @followedstocks = current_user.followed_stocks
    @followedstock = FollowedStock.new
    @stocks = Stock.all
  end

  def create
    @followedstock = FollowedStock.new(followedstock_params)
    @followedstock.user = current_user
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
    redirect_to followed_stocks_path
  end

  private

  def followedstock_params
    params.require(:followed_stock).permit(:stock_id)
  end
end
