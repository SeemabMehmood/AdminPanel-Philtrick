class WorkersController < ApplicationController
  load_and_authorize_resource

  before_action :set_worker, only: [:show, :edit, :update, :destroy]
  before_action :set_redirect_url, only: [:update]
  before_action :set_currencies, only: [:new, :edit, :create, :update]

  def index
    @workers = current_user.admin ? Worker.all : Worker.get_customer_workers(current_user)
    @workers = @workers.paginate(page: params[:page], per_page: Worker::PER_PAGE)
  end

  def offline
    @workers = Worker.offline.paginate(page: params[:page], per_page: Worker::PER_PAGE)
    respond_to do |format|
      format.html { render 'workers/index' }
    end
  end

  def show
    @worker_users = @worker.users.paginate(page: params[:page], per_page: Worker::PER_PAGE)
    @deposits = @worker.deposits.order_by_date.paginate(page: params[:page], per_page: Worker::PER_PAGE)
  end

  def new
    @worker = Worker.new
  end

  def edit
  end

  def create
    @worker = Worker.new(worker_params)

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
      if @worker.update(worker_params.except(:action_name))
        format.html { redirect_to @redirect_url, notice: 'Worker was successfully updated.' }
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
    valid, message = @worker.validate_customers(params)
    if valid
      @worker.add_customer(params[:user_id].to_i, params[:worker_count])
      respond_to do |format|
        format.html { redirect_to @worker, notice: 'Customers were successfully added.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to worker_select_customers_path, alert: message }
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
      params.require(:worker).permit(:title, :description, :electricity_cost,
                                      :action_name, :total_workers, :currency_id)
    end

    def set_redirect_url
      @redirect_url = workers_path
      @redirect_url = @worker if worker_params[:action_name] == 'show'
    end

    def set_currencies
      @currencies = Currency.pluck(:code, :id)
    end
end
