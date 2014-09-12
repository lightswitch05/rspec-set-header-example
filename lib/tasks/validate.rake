task :validate do
  puts "\n\n-----------------Resetting test and dev databases-------------------"
  Rake::Task["db:hard_reset"].invoke

  puts "\n\n-------------------------Running tests------------------------------"
  Rake::Task["spec"].invoke
end
