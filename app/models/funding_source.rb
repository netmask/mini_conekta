class FundingSource
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :card_number, :cvv, :exp_date, :in_card_name

  validates_presence_of :card_number, :cvv, :exp_date, :in_card_name

  validates :card_number, length: {in: 15..16}
  validates :cvv, length: {in: 3..4}
  validates :exp_date, length: {is: 4}

  validate :card_number_luhn

  CARDS_BANKS = {
      '3' => :amex,
      '4' => :visa,
      '5' => :master_card
  }

  def bank
    CARDS_BANKS[self.card_number.to_s[0]]
  end



  private

  def card_number_luhn
    errors.add(:base, 'The Credit card should be valid') unless luhn_valid card_number
  end

  def luhn_valid(number)
    s1 = s2 = 0
    number.to_s.reverse.chars.each_slice(2) do |odd, even|
      s1 += odd.to_i
      double = even.to_i * 2
      double -= 9 if double >= 10
      s2 += double
    end
    (s1 + s2) % 10 == 0
  end
end