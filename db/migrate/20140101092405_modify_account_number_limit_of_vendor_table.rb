class ModifyAccountNumberLimitOfVendorTable < ActiveRecord::Migration
  def up
  	change_table :Vendors do |t|
      t.change :number, :string, :limit => 12
    end
  end

  def down
	change_table :Vendors do |t|
      t.change :number, :integer
    end
  end
end
