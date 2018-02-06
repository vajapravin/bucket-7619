class CreateUids < ActiveRecord::Migration[5.1]
  def change
    create_table :uids do |t|
      t.string :identifier
      t.references :identifiable, polymorphic: true

      t.timestamps
    end
  end
end
