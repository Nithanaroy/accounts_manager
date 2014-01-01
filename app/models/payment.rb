class Payment < ActiveRecord::Base
  attr_accessible :acc_number, :amount, :payment_date, :vendor_acc_number
  before_create :set_foo_to_now
  def set_foo_to_now
  	print 'Came here'
    self.payment_date = Time.now
  end
end
