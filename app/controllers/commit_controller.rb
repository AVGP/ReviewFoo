class CommitController < ApplicationController
  def show
    @commit = Commit.find(:first, :conditions => "hash_id = '" + params[:hash_id] + "'")
  end

  def comment
  end

  def react
  end
end
