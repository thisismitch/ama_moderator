class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.datetime :when
      t.string :name
      t.string :description
      t.boolean :closed

      t.timestamps null: false
    end
  end
end
