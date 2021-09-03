class FollowedStocksController < ApplicationController
  def index
    @followedstocks = current_user.followed_stocks
    @followedstock = FollowedStock.new
    @stocks = Stock.all
    followed_acquisition_portfolio
  end

  def create
    @followedstock = FollowedStock.new(followed_stock_params)
    @followedstock.user = current_user
    @followedstock.save
    if @followedstock.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path, notice: 'This stock is already in your list!')
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

  def followed_acquisition_portfolio
    set_client
    @followed_stocks = current_user.followed_stocks
    @grouped_followed_stocks = @followed_stocks.group_by(&:stock_id)
    @stock_market_prices = {}
    @grouped_followed_stocks.each do |stock_id, followed_stock_array|
      stock_api = @client.quote(Stock.find(stock_id).ticker)
      @stock_market_prices[stock_id] = {
        latest_price: stock_api.latest_price.round(1), change_percent_s: stock_api.change_percent_s }
    end
  end

  private

  def followed_stock_params
    params.require(:followed_stock).permit(:stock_id)
  end
end
