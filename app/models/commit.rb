class Commit < ActiveRecord::Base
  belongs_to :repository
  has_many :commit_diffs
  attr_accessible :author, :date, :hash_id, :message, :repository_id, :branch_name, :accepted
  
  def to_param
    self.hash_id
  end
end
