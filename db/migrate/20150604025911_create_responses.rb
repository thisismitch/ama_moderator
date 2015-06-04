class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :question_id
      t.string :copy
      t.boolean :deleted
      t.boolean :anonymous_flag

      t.timestamps null: false
    end
  end
end
