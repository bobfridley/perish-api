class CreatePerishables < ActiveRecord::Migration
  def change
    create_table :perishables do |t|
      t.string :digest

      t.timestamps null: false
    end
    add_index :perishables, :digest, unique: true
  end
end
