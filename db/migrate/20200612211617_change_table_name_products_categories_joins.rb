class ChangeTableNameProductsCategoriesJoins < ActiveRecord::Migration[6.0]
  def change
    rename_table :products_categories_joins, :categories_products
  end
end
