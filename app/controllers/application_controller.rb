class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def portfolio
    set_client
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
          total_money_value: total_money_value, total_stock_count: total_stock_count, market_value: market_value.round(1) }
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
end
