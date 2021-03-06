namespace :repository do
  task :scan => :environment do
    Repository.all.each do |repo|
      Mercurial::Repository.open(repo.url).commits.all.each do |repoCommit|
        #only put the commit in the database, if we haven't it already in there
        if Commit.find(:first, :conditions => "hash_id = '" + repoCommit.hash_id + "'").nil?
          fullAuthor = repoCommit.author + "<" + repoCommit.author_email + ">"
          commit = Commit.create!(
            :author => fullAuthor, 
            :date => repoCommit.date,
            :hash_id => repoCommit.hash_id,
            :message => repoCommit.message,
            :branch_name => repoCommit.branch_name,
            :repository_id => repo.id
          )
          
          repoCommit.diffs.each do |diff|
            CommitDiff.create!(
              :commit_id => commit.id,
              :content => diff.body,
              :path => diff.file_b
            )
          end
        end
      end
    end
  end
end