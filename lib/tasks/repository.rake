namespace :repository do
  task :scan => :environment do
    Repository.all.each do |repo|
      Mercurial::Repository.open(repo.url).commits.all.each do |repoCommit|
        fullAuthor = repoCommit.author + "<" + repoCommit.author_email + ">"
        commit = Commit.create!(
          :author => fullAuthor, 
          :date => repoCommit.date,
          :hash => repoCommit.hash,
          :message => repoCommit.message
        )
      end
    end
  end
end