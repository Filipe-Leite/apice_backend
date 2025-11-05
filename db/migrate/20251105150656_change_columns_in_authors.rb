class ChangeColumnsInAuthors < ActiveRecord::Migration[7.1]
    def change
    remove_column :authors, :first_name, :string
    remove_column :authors, :surname, :string

    add_column :authors, :name, :string
    add_column :authors, :reference, :string
  end
end
