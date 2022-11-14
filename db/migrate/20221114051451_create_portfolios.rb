class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.integer :user_id, null: false, default: ""
      t.string :name, null: false, default: ""
      t.text :outline, null: false, default: ""
      t.text :url, null: false, default: ""
      t.boolean :is_public, null: false, default: true

      t.timestamps
    end
  end
end
