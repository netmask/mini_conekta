require 'rails_helper'

RSpec.describe FundingSourcesController, type: :controller do
  render_views

  before do
    request.env['HTTP_ACCEPT'] = "application/json"
    request.env['CONTENT_TYPE'] = "application/json"
  end

  let(:json) { JSON.parse(response.body) }

  let :funding_source_json do
    {funding_source: {card_number: '4111111111111111',
                      cvv:'123',
                      exp_date:'0218',
                      in_card_name: 'jonathan garay'}}
  end



  let :invalid_card do
    {funding_source: {card_number: '411',
                      cvv:'123',
                      exp_date:'0218',
                      in_card_name: 'jonathan garay'}}
  end

  let :wrong_funding_source_json do
    {funding_source: {}}
  end

  describe 'POST #create' do
    context 'the user sends the correct params' do
      it 'Should create a new tokenised funding source' do
        post :create, funding_source_json
        expect(response).to have_http_status(:success)
        expect(response.body).to_not be_empty
        expect(json['token']).to_not be_empty
      end
    end

    context 'the user sends incorrect params' do
      it 'Should fail cruel' do
        expect{post :create, wrong_funding_source_json}.to raise_exception
      end
    end

    context 'the User sends invalid information' do
      it 'Should fail cruel' do
        post :create, invalid_card
        expect(response).to have_http_status(422)
      end
    end
  end

end
