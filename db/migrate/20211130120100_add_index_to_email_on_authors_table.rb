class AddIndexToEmailOnAuthorsTable < ActiveRecord::Migration[6.1]
  def change
    add_index :authors, :email, unique: true
  end
end
