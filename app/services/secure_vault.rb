class SecureVault
  attr_accessor :redis

  def self.redis
    Redis.new
  end

  def self.store(token)
    redis.set token.id, token.encrypted_payload
    redis.expire token.id, 10
  end

  def self.retrieve(token_id)
    encrypted_payload = redis.get(token_id)
    SecureToken.new id: token_id, encrypted_payload: encrypted_payload if encrypted_payload
  end
end