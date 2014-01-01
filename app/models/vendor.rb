class Vendor < ActiveRecord::Base
  attr_accessible :name, :number, :pending_amount
end
