require_relative "./pluck_to_hash/version"

module PluckToHash
  extend ActiveSupport::Concern

  module ClassMethods
    def pluck_to_hash(*keys)
      pluck(*keys).map{|row| Hash[keys.zip(Array(row))]}
    end

    alias_method :pluck_h, :pluck_to_hash
  end
end

ActiveRecord::Base.send(:include, PluckToHash)
