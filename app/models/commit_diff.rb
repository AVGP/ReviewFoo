class CommitDiff < ActiveRecord::Base
  attr_accessible :commit_id, :content, :path
end
