class AddNewColumnToFood < ActiveRecord::Migration
  def change
    add_column :foods, :category, :string
  end
end
