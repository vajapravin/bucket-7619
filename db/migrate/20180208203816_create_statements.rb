class CreateStatements < ActiveRecord::Migration[5.1]
  def change
    create_table :statements do |t|
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
