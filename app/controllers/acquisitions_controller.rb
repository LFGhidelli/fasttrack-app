class AcquisitionsController < ApplicationController
  def new
    @acquisition = Acquisition.new
    @acquisition.stock = @stock
    # authorize @acquisition
  end

  def create
    @acquisition = Acquisition.new(acquisition_params)
    @acquisition.user = current_user
    # authorize @stock
    # authorize @acquisition
    if @acquisition.save
      redirect_to portfolio_path(@acquisition.id, @acquisition.stock_id), notice: 'Buy Acquisition Added.'
    else
      render :new
    end
  end

  def update
    @acquisition = Acquisition.find(params[:id])
    @acquisition.update(acquisition_params)
    redirect_to acquisition_path(@acquisition)
  end

  def sell_acquisition
    set_client
    @acquisition = Acquisition.new(acquisition_params)
    @acquisition.user = current_user
    @acquisition.value_bought = -@client.quote(@acquisition.stock.ticker).latest_price
    @acquisition.amount_bought = -@acquisition.amount_bought
    @acquisition.date_bought = Date.today
    # authorize @stock
    # authorize @acquisition
    if @acquisition.save
      redirect_to portfolio_path(@acquisition.id, @acquisition.stock_id), notice: 'Sell Acquisition Added.'
    else
      render portfolio_path
    end
  end

  private

  def acquisition_params
    params.require(:acquisition).permit(:value_bought, :amount_bought, :stock_id)
  end
end
