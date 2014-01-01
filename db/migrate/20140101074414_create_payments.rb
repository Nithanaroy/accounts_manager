class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :acc_number, :null => false
      t.integer :vendor_acc_number, :null => false
      t.float :amount
      t.datetime :payment_date, :null => false

      t.timestamps
    end
  end
end
