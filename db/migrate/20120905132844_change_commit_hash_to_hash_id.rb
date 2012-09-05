class ChangeCommitHashToHashId < ActiveRecord::Migration
  def up
    change_table :commits do |t|
      t.rename :hash, :hash_id
    end
  end

  def down
    change_table :commits do |t|
      t.rename :hash_id, :hash
    end
  end
end
