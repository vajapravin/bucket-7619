class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.integer :event_type

      t.timestamps
    end
  end
end
