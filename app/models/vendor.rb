class Vendor < ActiveRecord::Base
  attr_accessible :name, :number, :pending_amount

  def add_pending_amount(amount)
  	self.pending_amount += amount
  	self.save!
  end
end
