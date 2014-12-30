class AddViewsToBlueridge < ActiveRecord::Migration
  def change
    add_column :blueridges, :views, :string
  end
end
