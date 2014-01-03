class Payment < ActiveRecord::Base
  attr_accessible :acc_number, :amount, :payment_date, :vendor_acc_number
  
  belongs_to :account, :primary_key => "number", :foreign_key => "acc_number"
  belongs_to :vendor, :primary_key => "number", :foreign_key => "vendor_acc_number"

  before_create :set_payment_date_to_now

  validates :acc_number, :amount, :payment_date, :vendor_acc_number, presence: true
  validates :amount, numericality:

  def set_payment_date_to_now
    self.payment_date = Time.now
  end
end
