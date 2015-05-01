require "pluck_to_hash/version"

module PluckToHash
  extend ActiveSupport::Concern

  module ClassMethods
  	def pluck_to_hash(keys)
      if keys.is_a? Array
        pluck(*keys).map{|row| Hash[*[keys, row].transpose.flatten]}
      else
      	pluck(*keys).map{|row| Hash[*[[keys], [row]].transpose.flatten]}
      end
    end

    alias_method :pluck_h, :pluck_to_hash
  end
end

ActiveRecord::Base.send(:include, PluckToHash)