class Music < ActiveRecord::Base
  default_scope { where type: :music }
end
