class TransactionsController < ApplicationController
  load_and_authorize_resource

  skip_before_action :verify_authenticity_token, only: [:change_status]
  before_action :set_transaction, only: [:destroy]

  def index
    @transactions = current_user.admin? ? Transaction.all : current_user.transactions
    @transactions = @transactions.paginate(page: params[:page], per_page: Worker::PER_PAGE)
  end

  def withdraw
    @transaction = Transaction.build_new(transaction_params, current_user)
    @message = @transaction.save! ? "Withdrawal Request Sent Successfully." : "Error occurred while placing Withdrawal Request.\nPlease Try again later!"
      respond_to do |format|
        format.js { render 'withdraw.js.erb' }
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
    @user = User.find(params[:user_id])
    @transaction = Transaction.find(params[:transaction_id])

    if @transaction.pending?
      @transaction.update_attributes(status: params[:status])

      if params[:status] == 'Approved'
        @user.update_net_income_for_currency(@transaction.amount, @transaction.currency.code)
        @user.save!
      end
    end

    respond_to :js
  end

  private
    def transaction_params
      params.permit(:currency, :amount)
    end

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
end
