class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :UserId
      t.references :post, null: false, foreign_key: true
      t.string :PostId

      t.timestamps
    end
  end
end
