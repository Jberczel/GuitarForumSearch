class AddViewsToMartin < ActiveRecord::Migration
  def change
    add_column :martins, :views, :string
  end
end
