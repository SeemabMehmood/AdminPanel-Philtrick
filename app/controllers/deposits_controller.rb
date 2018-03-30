class DepositsController < ApplicationController
  load_and_authorize_resource

  before_action :set_deposit, only: [:show, :edit, :update, :destroy]
  before_action :set_redirect_url, only: [:update]
  before_action :load_workers, only: [:new, :edit, :create, :update]

  def index
    @deposits = Deposit.all
    @deposits = @deposits.paginate(page: params[:page], per_page: Worker::PER_PAGE)
  end

  def show
  end

  def new
    @deposit = Deposit.new
  end

  def edit
  end

  def create
    @deposit = Deposit.new(deposit_params)

    respond_to do |format|
      if @deposit.save
        format.html { redirect_to @deposit, notice: 'Deposit was successfully created.' }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html { render :new }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deposit.update(deposit_params.except(:action_name))
        format.html { redirect_to @redirect_url, notice: 'Deposit was successfully updated.' }
        format.json { render :show, status: :ok, location: @deposit }
      else
        format.html { render :edit }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deposit.destroy
    respond_to do |format|
      format.html { redirect_to deposits_url, alert: 'Deposit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_deposit
      @deposit = Deposit.find(params[:id])
    end

    def deposit_params
      params.require(:deposit).permit(:worker_id, :income)
    end

    def set_redirect_url
      @redirect_url = deposits_path
      @redirect_url = @deposit if deposit_params[:action_name] == 'show'
    end

    def load_workers
      @workers = Worker.active
    end
end
