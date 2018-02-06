class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.integer :zip
      t.string :country
      t.string :state
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
