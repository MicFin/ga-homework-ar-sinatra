class CreateComments < ActiveRecord::Migration
  def up
      create_table :comments do |t|
      t.string :author
      t.text :body
      t.timestamps
    end
  end

  def down
      drop_table :posts
  end
end