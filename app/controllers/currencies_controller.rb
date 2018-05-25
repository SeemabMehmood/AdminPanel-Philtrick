class CurrenciesController < ApplicationController
  load_and_authorize_resource

  before_action :set_currency, only: [:edit, :update]

  def index
    @currencies = Currency.all
    @currencies = @currencies.paginate(page: params[:page], per_page: Worker::PER_PAGE)
  end

  def update
    respond_to do |format|
      if @currency.update(currency_params)
        format.html { redirect_to currencies_path, notice: 'Currency Price was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_currency
      @currency = Currency.find(params[:id])
    end

    def currency_params
      params.require(:currency).permit(:price)
    end
end
