class AddAdminApprovedToQuestionsAndResponses < ActiveRecord::Migration
  def change
    add_column :questions, :admin_approved_by_user_id, :integer
    add_column :questions, :admin_approved_at, :datetime
    add_column :responses, :admin_approved_by_user_id, :integer
    add_column :responses, :admin_approved_at, :datetime
  end
end
