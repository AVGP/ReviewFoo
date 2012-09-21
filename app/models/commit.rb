class Commit < ActiveRecord::Base
  belongs_to :repository
  has_many :commit_diffs
  attr_accessible :author, :date, :hash_id, :message, :repository_id, :branch_name, :accepted

  after_initialize :defaults
  
  def defaults
    self.accepted = 0 unless self.accepted
  end
  
  def to_param
    self.hash_id
  end
end
