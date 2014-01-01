class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :number, :null => false
      t.string :name, :null => false
      t.float :balance, :default => 0
      t.string :type, :default => 'SAVINGS'
      t.float :post_dated, :default => 0

      t.timestamps
    end
  end
end
