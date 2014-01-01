class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.integer :number, :null => false
      t.string :name, :null => false
      t.float :pending_amount, :default => 0

      t.timestamps
    end
  end
end
