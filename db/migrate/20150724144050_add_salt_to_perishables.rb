class AddSaltToPerishables < ActiveRecord::Migration
  def change
    add_column :perishables, :salt, :string
  end
end
