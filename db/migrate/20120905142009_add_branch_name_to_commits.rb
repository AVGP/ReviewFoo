class AddBranchNameToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :branch_name, :string
  end
end
