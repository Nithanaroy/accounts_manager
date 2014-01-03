class Account < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessible :balance, :name, :number, :post_dated, :acc_type

  has_many :payments, :primary_key => "number", :foreign_key => "acc_number"

  validates :balance, :name, :number, :post_dated, :acc_type, presence: true
  validates :balance, :post_dated, numericality:

  def balance_display
  	number_to_currency(self.balance)
  end

  def post_dated_display
  	number_to_currency(self.post_dated)
  end

  def add_balance(amount)
  	self.balance += amount
  	self.save!
  end
end
