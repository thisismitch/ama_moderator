class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :role_id
      t.string :email
      t.string :name
      t.string :location

      t.timestamps null: false
    end
  end
end
