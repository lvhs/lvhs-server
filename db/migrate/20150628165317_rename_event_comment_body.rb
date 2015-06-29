class RenameEventCommentBody < ActiveRecord::Migration
  def change
    rename_column :event_comments, :comment, :body
  end
end
