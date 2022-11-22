class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :portfolio_id
      t.integer :user_id
      t.text :comment
      t.float :evaluation

      t.timestamps
    end
  end
end
