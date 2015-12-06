class RenameScheduledColumn < ActiveRecord::Migration
  def change
    rename_column :events, :scheduled_datetime, :scheduled_at
  end
end
