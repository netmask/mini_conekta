class Payment
  include ActiveModel::Model
  include Mongoid::Document

  attr_accessor :token

  field :bin_number, type: Numeric
  field :auth_code, type: String

  field :card_holder_name, type: String
  field :last_digits, type: Numeric
  field :bank, type: String
  field :cvv, type: String
  field :exp_date, type: String
  field :amount, type: Numeric
end