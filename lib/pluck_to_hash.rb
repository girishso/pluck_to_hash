# frozen_string_literal: true

if defined?(Rails)
  require 'pluck_to_hash/railtie'
else
  require 'active_record'
  require 'pluck_to_hash/pluck_to_concern'
  ActiveRecord::Base.send(:include, PluckToConcern)
end
