class AddColumnsIntoActivity < ActiveRecord::Migration[5.1]
  def change
    change_table :activities do |t|
      t.references :invocation, polymorphic: true
    end
  end
end
