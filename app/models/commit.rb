class Commit < ActiveRecord::Base
  belongs_to :repository
  attr_accessible :author, :date, :hash, :message
end
