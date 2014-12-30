class CreateBlueridges < ActiveRecord::Migration
  def change
    create_table :blueridges do |t|
      t.string :title
      t.string :link
      t.string :author
      t.string :last_post
      t.string :replies
      t.timestamps
    end
  end
end
