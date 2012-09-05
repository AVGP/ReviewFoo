class Commit < ActiveRecord::Base
  belongs_to :repository
  attr_accessible :author, :date, :hash_id, :message, :repository_id, :branch_name
end
