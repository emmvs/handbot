task :lint do
  puts 'Linting your Ruby files with RuboCop...'
  sh 'rubocop'
end
