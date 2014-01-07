class Cheque < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessible :acc_number, :amount, :dated_on, :number, :vendor_acc_number

  belongs_to :account, :primary_key => "number", :foreign_key => "acc_number"
  belongs_to :vendor, :primary_key => "number", :foreign_key => "vendor_acc_number"

  before_create :set_dated_on_to_now

  validates :acc_number, :amount, :dated_on, :vendor_acc_number, presence: true
  validates :amount, numericality:

  def amount_display
  	number_to_currency(self.amount)
  end

  def set_dated_on_to_now
    self.dated_on = Time.now
  end
end
