class CreatePortfolioTags < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolio_tags do |t|
      t.integer :portfolio_id, null: false, default: ""
      t.integer :tag_id, null: false, default: ""

      t.timestamps
    end
  end
end
