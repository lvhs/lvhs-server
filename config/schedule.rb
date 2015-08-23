job_type :rbenv_rake, %q!eval "$(rbenv init -)"; cd :path && :environment_variable=:environment :bundle_command rake :task --silent :output!

every 1.minute do
  rbenv_rake 'vimeo:publish'
end
