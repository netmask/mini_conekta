class PaymentsController < ApplicationController

  def index
    render :json => Payment.all
  end

  def create
    payment = Payment.new payment_params
    gateway = BogusGateway.new

    if gateway.process payment
      render :json => payment
    else
      render :json => { :error => gateway.messages }, :status => 422
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :token)
  end
end
