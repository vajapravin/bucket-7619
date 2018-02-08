class AddColumnIntoUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :amount, :float, default: 0
  end
end
