class SecureVault
  attr_accessor :redis

  SENTINELS = [{:host => '127.0.0.1', :port => 26379}]

  def self.redis
    Rails.env.production? ? Redis.new(:url => 'redis://mymaster', :sentinels => SENTINELS, :role => :master) : Redis.new
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