class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :outline, null: false
      t.text :url, null: false
      t.float :evaluation_average
      t.boolean :is_public, null: false, default: true

      t.timestamps
    end
  end
end
