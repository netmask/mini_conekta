class SecureToken
  include ActiveModel::Model
  extend AttrEncrypted

  attr_accessor :id, :created_at, :expires_in, :encrypted_payload
  attr_encrypted :payload, key: 'p>jvUcVx3Y$4rHFk$8C[C68=k2YAb3h.PqkU?96MbVRzh@??Z4'

  def self.with_payload(payload)
    self.new id: SecureRandom.urlsafe_base64, payload: payload
  end
end