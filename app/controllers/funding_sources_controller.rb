class FundingSourcesController < ApplicationController
  def create
    funding_source = FundingSource.new funding_source_params

    if funding_source.valid?
      @token = Tokeniser.create funding_source

      render :json => { :token => @token.id }
    else
      render :json => { :error => funding_source.errors.messages }, :status => 422
    end
  end

  private
  def funding_source_params
    params.require(:funding_source)
        .permit(:card_number, :cvv, :exp_date, :in_card_name)
  end
end
