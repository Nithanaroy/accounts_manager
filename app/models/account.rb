class Account < ActiveRecord::Base
  attr_accessible :balance, :name, :number, :post_dated, :acc_type

  has_many :payments, :primary_key => "number", :foreign_key => "acc_number"

  validates :balance, :name, :number, :post_dated, :acc_type, presence: true
  validates :balance, :post_dated, numericality:

  def add_balance(amount)
  	self.balance += amount
  	self.save!
  end
end
