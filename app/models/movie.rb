class Movie < ActiveRecord::Base
  default_scope { where type: :movie }
end
