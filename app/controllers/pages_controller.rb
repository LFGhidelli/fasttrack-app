class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    set_client
  end

  def portfolio
    set_client
    set_acquisitions
    @followedstock = FollowedStock.new
    set_client
    set_totals
    @net = @total_market_value-@total_paid_value
    @net_percent = (@net/@total_paid_value)*100
    @followed_stocks = current_user.followed_stocks
    @grouped_followed_stocks = @followed_stocks.group_by(&:stock_id)
    @stock_market_prices = {}
    @grouped_followed_stocks.each do |stock_id, _followed_stock_array|
      stock_api = @client.quote(Stock.find(stock_id).ticker)
      @stock_market_prices[stock_id] = {
        stock_name: stock_api.company_name, latest_price: stock_api.latest_price.round(1), change_percent_s: stock_api.change_percent_s, change_percent: stock_api.change_percent }
    end
  end

  def dashboard
    @followedstock = FollowedStock.new
    set_client
    set_totals
    set_acquisitions
    unless @total_market_value.zero? || @total_paid_value.zero?
      @net = @total_market_value - @total_paid_value
      @net_percent = ( @net / @total_paid_value ) * 100
    end
    @followed_stocks = current_user.followed_stocks
    @grouped_followed_stocks = @followed_stocks.group_by(&:stock_id)
    @stock_market_prices = {}
    @grouped_followed_stocks.each do |stock_id, _followed_stock_array|
      stock_api = @client.quote(Stock.find(stock_id).ticker)
      @stock_market_prices[stock_id] = {
        stock_name: stock_api.company_name, latest_price: stock_api.latest_price.round(1), change_percent_s: stock_api.change_percent_s, change_percent: stock_api.change_percent }
    end
  end

  private

  def set_client
    @client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      secret_token: ENV['IEX_API_SECRET_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end


  def set_acquisitions
    @acquisitions = current_user.acquisitions
    @grouped_acquisitions = @acquisitions.group_by(&:stock_id)
    @stock_total_value = {}
    @acquisition = Acquisition.new
    @grouped_acquisitions.each do |stock_id, acquisition_array|
      stock_api = @client.quote(Stock.find(stock_id).ticker)
      total_money_value = 0
      total_stock_count = 0
      market_value = 0
      acquisition_array.each do |acquisition|
        total_money_value += acquisition.value_bought * acquisition.amount_bought
        total_stock_count += acquisition.amount_bought
        market_value += acquisition.amount_bought * stock_api.latest_price
      end
      @stock_total_value[stock_id] = {
        total_money_value: total_money_value,
        total_stock_count: total_stock_count,
        market_value: market_value.round(1),
        market_percentage_change: stock_api.change_percent
      }
    end
  end

  def set_totals
    set_acquisitions
    @total_market_value = 0
    @total_stock_count = 0
    @total_paid_value = 0
    @stock_total_value.values.each do |hash|
      @total_market_value += hash[:market_value]
      @total_stock_count += hash[:total_stock_count]
      @total_paid_value += hash[:total_money_value]
    end
  end
end
