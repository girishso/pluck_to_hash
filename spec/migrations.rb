require 'active_record'

def run_migrations
  # Turns off messaging during spec running of table creation
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Schema.define do
    create_table :test_models do |t|
      t.string :test_attribute
      t.string :serialized_attribute
      t.integer :price_1
      t.integer :price_2
    end
    create_table :test_model_children do |t|
      t.integer :test_model_id
      t.string :children_name
    end
  end
end

class TestModel < ActiveRecord::Base
  serialize :serialized_attribute, Array
  has_many :test_model_children
end

class TestModelChild < ActiveRecord::Base
  belongs_to :test_model
end
