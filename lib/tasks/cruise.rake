desc "VH cruise tasks"
task :cruise do
	puts "Rake task for CI"
	Rake::Task['db:migrate'].execute
	Rake::Task['db:prepare'].execute
	Rake::Task['spec'].execute
end	