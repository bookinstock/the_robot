require 'dotenv/load'
require 'dotenv/tasks'

desc "test"
task :test do
    puts "simple test"

    puts "ACCESS_KEY=#{ENV['ACCESS_KEY']}"
    puts "SECRET_KEY=#{ENV['SECRET_KEY']}"
end

namespace :backup do
    task :create do
        puts "create"
    end
    task :list do
        puts "list"
    end
    task :restore do
        puts "restore"
    end
end

#  depend

task :a do
    puts "a"
end

task b: :a do
    puts "b"
end

task c: :b do
    puts "c"
end