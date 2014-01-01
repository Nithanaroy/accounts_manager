class Account < ActiveRecord::Base
  attr_accessible :balance, :name, :number, :post_dated, :type
end
