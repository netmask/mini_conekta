class SecureVault
  attr_accessor :redis

  def self.store(token)
    Redis.new.set token.id, token.encrypted_payload
  end

  def self.retrieve(token_id)
    SecureToken.new id: token_id, encrypted_payload: Redis.new.get(token_id)
  end
end