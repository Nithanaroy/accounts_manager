class Vendor < ActiveRecord::Base
  attr_accessible :name, :number, :pending_amount, :acc_name

  has_many :payments, :primary_key => "number", :foreign_key => "vendor_acc_number"

  validates :name, :number, :pending_amount, presence: true
  validates :pending_amount, numericality:

  def add_pending_amount(amount)
  	self.pending_amount += amount
  	self.save!
  end
end
