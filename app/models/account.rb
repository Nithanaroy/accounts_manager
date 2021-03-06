class Account < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessible :balance, :name, :number, :acc_type

  has_many :payments, :primary_key => "number", :foreign_key => "acc_number"
  has_many :cheques, :primary_key => "number", :foreign_key => "acc_number"

  validates :balance, :name, :number, :acc_type, presence: true
  validates :balance, numericality:

  def affective_balance
    self.balance - self.post_dated
  end

  def affective_balance_display
    number_to_currency(self.affective_balance)
  end

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

  def post_dated
    self.cheques.sum(&:amount)
  end
end
