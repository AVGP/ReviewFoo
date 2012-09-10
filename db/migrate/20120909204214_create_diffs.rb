class CreateDiffs < ActiveRecord::Migration
  def change
    create_table :commit_diffs do |t|
      t.integer :commit_id
      t.string :path
      t.string :content

      t.timestamps
    end
  end
end
