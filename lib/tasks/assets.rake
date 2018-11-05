namespace :assets do
  desc 'assets precompilation'
  task :precompile do
    exec('jekyll build')
  end
end
