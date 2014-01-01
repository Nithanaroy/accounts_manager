class ModifyAccNumbersForPaymentsTable < ActiveRecord::Migration
  def up
  	change_table :Payments do |t|
      t.change :acc_number, :string, :limit => 12
      t.change :vendor_acc_number, :string, :limit => 12
    end
  end

  def down
  	change_table :Payments do |t|
      t.change :acc_number, :integer
      t.change :vendor_acc_number, :integer
    end
  end
end
