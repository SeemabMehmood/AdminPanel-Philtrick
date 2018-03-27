class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.customers.paginate(page: params[:page], per_page: Worker::PER_PAGE)
  end

  def show
    @user_workers = @user.workers.paginate(page: params[:page], per_page: Worker::PER_PAGE)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.initialize_user(new_user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(edit_user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, alert: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_workers
    @user = User.find(params[:user_id])
    @workers = Worker.all
  end

  def add_workers
    @user = User.find(params[:user_id])
    if params[:worker_ids].present?
      @user.add_workers(params[:worker_ids])
      respond_to do |format|
        format.html { redirect_to @user, notice: 'Workers were successfully added.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_select_workers_path, alert: 'Please select any worker from the list.' }
        format.json { head :no_content }
      end
    end
  end

  def remove_worker
    @user = User.find(params[:user_id])
    @user.user_workers.find_by_worker_id(params[:worker_id]).destroy
    respond_to do |format|
      format.html { redirect_to @user, alert: "Worker for Customer #{@user.name.titleize} was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def new_user_params
      params.require(:user).permit(:name, :email, :username, :company_name, :zip, :country, :street_name, :profit_share, :net_income, :worker_id)
    end

    def edit_user_params
      params.require(:user).permit(:name, :company_name, :zip, :country, :street_name, :profit_share, :net_income)
    end
end
