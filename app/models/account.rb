class Account < ActiveRecord::Base
  attr_accessible :balance, :name, :number, :post_dated, :acc_type
end
