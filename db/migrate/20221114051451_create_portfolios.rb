class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.integer :user_id, null: false
      t.string :name, null: false, default: ""
      t.text :outline, null: false
      t.text :site_url, null: false
      t.text :code_url, null: false
      t.float :evaluation_average, default: 0.0
      t.boolean :is_public, null: false, default: true

      t.timestamps
    end
  end
end
