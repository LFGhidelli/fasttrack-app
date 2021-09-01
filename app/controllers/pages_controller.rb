class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @client = IEX::Api::Client.new
    @testclient = IEX::Api::Client.new(
      publishable_token: 'pk_44b3db4eecfd4104b95aad7b4e595236',
      secret_token: 'sk_07ff8fe366e04362a736800330e4f52b',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end

  def portfolio
    @acquisitions = current_user.acquisitions
    @grouped_acquisitions = @acquisitions.group_by(&:stock_id)
    @stock_total_value = {}

    @grouped_acquisitions.each do |stock_id, acquisition_array|
      total_value = 0
      total_amount = 0
      acquisition_array.each do |acquisition|
        total_value += acquisition.value_bought
        total_amount += acquisition.amount_bought
      end
      @stock_total_value[stock_id] = { total_value: total_value, total_amount: total_amount }
    end
  end
end
