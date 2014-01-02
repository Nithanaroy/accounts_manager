class Account < ActiveRecord::Base
  attr_accessible :balance, :name, :number, :post_dated, :acc_type

  def add_balance(amount)
  	self.balance += amount
  	self.save!
  end
end
