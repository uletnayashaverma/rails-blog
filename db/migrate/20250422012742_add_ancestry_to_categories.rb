class AddAncestryToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :ancestry, :string
  end
end
