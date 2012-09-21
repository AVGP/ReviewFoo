class CommitController < ApplicationController
  def show
    @commit = Commit.find(:first, :conditions => "hash_id = '" + params[:hash_id] + "'")
  end

  def comment
  end

  def reject
    commit = Commit.find(:first, :conditions => "hash_id = '" + params[:hash_id] + "'")    
    commit.accepted = -1 unless commit.nil?
    commit.save!
    redirect_to commit_path(commit)
  end
end
