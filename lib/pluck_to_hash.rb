require "pluck_to_hash/version"

module PluckToHash
  extend ActiveSupport::Concern

  module ClassMethods
  	def pluck_to_hash(keys)
      pluck(*keys).map{|row| Hash[*[Array(keys), Array(row)].transpose.flatten]}
    end

    alias_method :pluck_h, :pluck_to_hash
  end
end

ActiveRecord::Base.send(:include, PluckToHash)
