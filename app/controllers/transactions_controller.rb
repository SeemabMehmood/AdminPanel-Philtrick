class TransactionsController < ApplicationController
  load_and_authorize_resource

  skip_before_action :verify_authenticity_token, only: [:change_status]
  before_action :set_transaction, only: [:destroy]

  def index
    @transactions = Transaction.all
    @transactions = @transactions.paginate(page: params[:page], per_page: Worker::PER_PAGE)
  end

  def withdraw
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save!
        format.html { redirect_to @transaction, notice: 'transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, alert: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    @transaction = Transaction.find(params[:transaction_id])
    @transaction.update_attributes(status: params[:status])
    @user = User.find(params[:user_id])

    if @transaction.approved?
      @user.update_net_income_for_currency(@transaction.amount, @transaction.currency.code)
      @user.save!
    end

    respond_to :js
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
end
