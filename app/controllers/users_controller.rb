class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(new_user_params)

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

    if @user.update(edit_user_params)
      respond_to do |format|
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      end
    else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def new_user_params
      params.require(:user).permit(:id, :name, :email, :username, :company_name, :zip, :country, :street_name, :profit_share, :net_income)
    end

    def edit_user_params
      params.require(:user).permit(:id, :name, :company_name, :zip, :country, :street_name, :profit_share, :net_income)
    end
end
