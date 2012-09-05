namespace :repository do
  task :scan => :environment do
    Repository.all.each do |repo|
      Mercurial::Repository.open(repo.url).commits.all.each do |repoCommit|
        fullAuthor = repoCommit.author + "<" + repoCommit.author_email + ">"
        if Commit.find(:first, :conditions => "hash_id = '" + repoCommit.hash_id + "'").nil?
          commit = Commit.create!(
            :author => fullAuthor, 
            :date => repoCommit.date,
            :hash_id => repoCommit.hash_id,
            :message => repoCommit.message
          )
        end                  
      end
    end
  end
end