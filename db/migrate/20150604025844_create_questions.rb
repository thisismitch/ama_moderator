class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :copy
      t.boolean :anonymous_flag
      t.boolean :closed
      t.boolean :deleted

      t.timestamps null: false
    end
  end
end
