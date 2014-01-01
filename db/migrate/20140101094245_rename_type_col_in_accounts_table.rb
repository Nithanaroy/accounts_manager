class RenameTypeColInAccountsTable < ActiveRecord::Migration
  def up
  	rename_column :Accounts, :type, :acc_type
  end

  def down
  	rename_column :Accounts, :acc_type, :type
  end
end
