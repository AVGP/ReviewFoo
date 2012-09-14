class AddAcceptedToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :accepted, :boolean    
  end
end
