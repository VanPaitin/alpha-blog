class AddUserIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :user, foreign_key: true
    add_column :users, :password_digest, :string
  end
end
