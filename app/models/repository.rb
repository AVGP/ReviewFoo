class Repository < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :commits
  
  validates :name,  :presence => true
  validates :url,   :presence => true
end
