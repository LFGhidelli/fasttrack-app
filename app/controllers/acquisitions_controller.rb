class AcquisitionsController < ApplicationController
  def new
    @stock = stock.find(params[:stock_id])
    @acquisition = Acquisition.new
    @acquisition.stock = @stock
    authorize @acquisition
  end

  def create
    @acquisition = Acquisition.new(acquisition_params)
    @stock = stock.find(params[:stock_id])
    @acquisition.stock = @stock
    @acquisition.user = current_user
    authorize @stock
    authorize @acquisition

    if @acquisition.save
      redirect_to stock_acquisition_path(@acquisition.id, @stock.id), notice: 'your acquisition has been sent!'
    else
      render :new
    end
  end

  def update
    @acquisition = Acquisition.find(params[:id])
    @acquisition.update(acquisition_params)
    redirect_to acquisition_path(@acquisition)
  end

  private

  def acquisition_params
    params.require(:acquisition).permit(:value_bought, :amount_bought, :date_bought)
  end
end
