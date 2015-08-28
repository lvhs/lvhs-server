job_type :rbenv_rake, %q!
  export ANYENV_ROOT=/home/uehara.masayuki/.anyenv;
  export PATH=$ANYENV_ROOT/bin:$PATH;
  eval "$(anyenv init -)";
  cd :path && :bundle_command rake :task --silent :output;
!

every 1.minute do
  rbenv_rake 'vimeo:publish', output: 'log/crontab.log'
end
