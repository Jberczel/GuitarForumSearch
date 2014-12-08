class CreateMartins < ActiveRecord::Migration
  def change
    create_table :martins do |t|
      t.string :title
      t.string :link
      t.string :author
      t.string :last_post
      t.string :replies
      t.timestamps
    end
  end
end
