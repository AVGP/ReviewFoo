class AddAcceptedToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :accepted, :integer    
  end
end
