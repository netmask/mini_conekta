class Tokeniser

  def self.create(funding_source)
    token = SecureToken.with_payload(funding_source.to_json)
    SecureVault.store token
    token
  end

  def self.exchange(secure_token_id)
    secure_token = SecureVault.retrieve(secure_token_id)
    
    if secure_token
      funding_source = JSON.parse(secure_token.payload).except!('errors')
      FundingSource.new(funding_source)
    end
  end
end