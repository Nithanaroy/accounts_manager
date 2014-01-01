class Payment < ActiveRecord::Base
  attr_accessible :acc_number, :amount, :payment_date, :vendor_acc_number
end
