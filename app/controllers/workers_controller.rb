class WorkersController < ApplicationController
  load_and_authorize_resource

  before_action :set_worker, only: [:show, :edit, :update, :destroy]

  def index
    @workers = Worker.all
  end

  def show
  end

  def new
    @worker = Worker.new
  end

  def edit
  end

  def create
    @worker = Worker.initialize_worker(worker_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to @worker, notice: 'Worker was successfully created.' }
        format.json { render :show, status: :created, location: @worker }
      else
        format.html { render :new }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @worker.update(worker_params)
        format.html { redirect_to @worker, notice: 'Worker was successfully updated.' }
        format.json { render :show, status: :ok, location: @worker }
      else
        format.html { render :edit }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to workers_url, alert: 'Worker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_customers
    @worker = Worker.find(params[:worker_id])
    @users = User.customers
  end

  def add_customers
    @worker = Worker.find(params[:worker_id])
    if params[:user_ids].present?
      @worker.add_customers(params[:user_ids])
      respond_to do |format|
        format.html { redirect_to @worker, notice: 'Customers were successfully added.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to worker_select_customers_path, alert: 'Please select any customer from the list.' }
        format.json { head :no_content }
      end
    end
  end

  def remove_user
    @worker = Worker.find(params[:worker_id])
    @worker.user_workers.find_by_user_id(params[:user_id]).destroy
    respond_to do |format|
      format.html { redirect_to @worker,
                    alert: "Customer for Worker #{@worker.title.titleize} was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    def set_worker
      @worker = Worker.find(params[:id])
    end

    def worker_params
      params.require(:worker).permit(:title, :description, :electricity_cost, :net_income, :user_id)
    end
end
