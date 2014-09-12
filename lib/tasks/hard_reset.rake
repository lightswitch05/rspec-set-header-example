namespace :db do
  desc "Crush and burn the database"
  task :hard_reset do
    File.delete("db/schema.rb") if File.exist?("db/schema.rb")
    File.delete("db/development.sqlite3")if File.exist?("db/development.sqlite3")
    File.delete("db/test.sqlite3") if File.exist?("db/test.sqlite3")
    silence_stream(STDOUT) do
      Rake::Task["db:migrate"].invoke
    end
  end
end