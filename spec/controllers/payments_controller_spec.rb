require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  render_views

  describe 'POST #create' do
    let(:funding_source) do
      FundingSource.new({card_number: '4111111111111111',
                         cvv: '123',
                         exp_date: '0218',
                         in_card_name: 'jonathan garay'})
    end

    let(:token) { Tokeniser.create funding_source }


    context 'a valid token is provided' do
      it 'returns http success' do
        post :create, payment: {amount: 100, token: token.id}
        expect(response).to have_http_status(:success)
      end
    end

    context 'a invalid token is provided' do
      it 'returns http error' do
        post :create, payment: {amount: 100, token: 'invalid'}
        expect(response).to have_http_status(:error)
      end
    end
  end

end
