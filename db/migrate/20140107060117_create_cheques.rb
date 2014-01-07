class CreateCheques < ActiveRecord::Migration
  def change
    create_table :cheques do |t|
      t.string :number, :null => false
      t.float :amount, :null => false
      t.string :acc_number, :null => false
      t.string :vendor_acc_number, :null => false
      t.datetime :dated_on, :null => false

      t.timestamps
    end
  end
end
