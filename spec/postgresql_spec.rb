require 'active_record'
require_relative '../lib/pluck_to_hash'
require_relative './migrations'
require_relative './support/shared_examples'

describe 'PluckToHash with Postgres' do

  before(:all) do
    ActiveRecord::Base.remove_connection
    @db_name = "pluck_to_hash_test"
    %x( createdb -E UTF8 -T template0 #{@db_name} )
    ActiveRecord::Base.establish_connection(
      "adapter"  => "postgresql",
      "database" => @db_name
    )
    run_migrations()
  end

  after(:all) do
    ActiveRecord::Base.remove_connection
    %x( dropdb #{@db_name})
  end

  before { TestModel.delete_all }
  include_context 'making sure alias is fine'

  describe '.pluck_to_hash' do
    include_context 'essentials'
    include_context 'when using a different hash type'
  end

end
