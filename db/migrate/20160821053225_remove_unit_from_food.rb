class RemoveUnitFromFood < ActiveRecord::Migration
  def change
    remove_column :foods, :unit, :string
  end
end
