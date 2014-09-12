# The initial database schema for version 1.0
class Initialize < ActiveRecord::Migration
  def change

    # Access Tokens
    create_table :access_tokens do |table|
      table.string :access_token, null: false
      table.boolean :active, null: false, default: true
      table.timestamps
    end

    add_index :access_tokens, :access_token, unique: true

    # Posts
    create_table :posts do |table|
      table.string :title
      table.text :content
      table.timestamps
    end
  end

  def down
    drop_table :access_tokens
    drop_table :posts
  end
end
