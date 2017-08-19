require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'models/layout_config'

DataMapper.setup(:default, "postgres://localhost/bbc_layout_repository_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
