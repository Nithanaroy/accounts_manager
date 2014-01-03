class AddAccNameToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :acc_name, :string, :null => false, after: :id
  end
end
