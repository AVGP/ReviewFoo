class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :hash
      t.string :message
      t.string :author
      t.datetime :date
      t.references :repository

      t.timestamps
    end
    add_index :commits, :repository_id
  end
end
