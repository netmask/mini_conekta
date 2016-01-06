class BogusGateway

  attr_accessor :message

  def process(payment)
    if(funding_source = Tokeniser.exchange(payment.token))
      payment.assign_attributes stripe_information(payment, funding_source)
      payment.save
    else
      self.message = 'Your token as expired or is invalid'
      false #maybe an a exception ? :/
    end
  end


  private
  def stripe_information(payment, funding_source)
    {
        auth_code: SecureRandom.hex,
        bin_number: funding_source.card_number[0..5],
        card_holder_name: funding_source.in_card_name,
        last_digits: funding_source.card_number[-4..-1],
        bank: funding_source.bank.to_s,
        cvv: funding_source.cvv,
        exp_date: funding_source.exp_date,
        amount: payment.amount
    }
  end

end