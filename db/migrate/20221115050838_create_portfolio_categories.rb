class CreatePortfolioCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolio_categories do |t|
      t.integer :portfolio_id, null: false
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
