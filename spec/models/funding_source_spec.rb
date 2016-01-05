require 'rails_helper'

RSpec.describe FundingSource, type: :model do
  context 'the funding source is a bank card' do
    it 'should be a valid bank' do
      subject.card_number = '4111111111111111'
      expect(subject.bank).to be :visa

      subject.card_number = '3111111111111111'
      expect(subject.bank).to be :amex

      subject.card_number = '5111111111111111'
      expect(subject.bank).to be :master_card
    end
  end
end
