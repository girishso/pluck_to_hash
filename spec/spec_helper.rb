require 'active_record'
require_relative '../lib/pluck_to_hash'

ActiveRecord::Base.establish_connection(
  "adapter"  => "sqlite3",
  "database" => ":memory:"
)

# Turns off messaging during spec running of table creation
ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define do
  create_table :test_models do |t|
    t.string :test_attribute
    t.string :serialized_attribute
  end
end

class TestModel < ActiveRecord::Base
  serialize :serialized_attribute, Array
end
