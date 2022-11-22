class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :portfolio_id, default: ""
      t.integer :user_id, default: ""
      t.text :comment, default: ""
      t.float :evaluation, default: ""

      t.timestamps
    end
  end
end
