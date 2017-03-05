require 'active_record'
require_relative '../lib/pluck_to_hash'
require_relative './migrations'
require_relative './support/shared_examples'

ActiveRecord::Base.establish_connection(
  "adapter"  => "sqlite3",
  "database" => ":memory:"
)

run_migrations()
