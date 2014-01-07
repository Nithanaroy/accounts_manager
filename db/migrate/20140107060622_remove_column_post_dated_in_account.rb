class RemoveColumnPostDatedInAccount < ActiveRecord::Migration
  def up
  	remove_column :accounts, :post_dated
  end

  def down
  	add_column :accounts, :post_dated, :float, :null => false, after: :type
  end
end
