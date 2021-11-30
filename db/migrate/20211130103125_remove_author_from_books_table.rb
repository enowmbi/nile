class RemoveAuthorFromBooksTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :author, type: :string
  end
end
