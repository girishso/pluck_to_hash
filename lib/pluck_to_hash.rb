require_relative "./pluck_to_hash/version"

module PluckToHash
  extend ActiveSupport::Concern

  module ClassMethods
    def pluck_to_hash(*keys)
      block_given = block_given?
      keys, formatted_keys = format_keys(keys)
      keys_one = keys.size == 1

      pluck(*keys).map do |row|
        value = HashWithIndifferentAccess[formatted_keys.zip(keys_one ? [row] : row)]
        block_given ? yield(value) : value
      end
    end

    def pluck_to_struct(*keys)
      block_given = block_given?
      keys, formatted_keys = format_keys(keys)
      keys_one = keys.size == 1

      struct = Struct.new(*formatted_keys.map(&:to_sym))
      pluck(*keys).map do |row|
        value = keys_one ? struct.new(*[row]) : struct.new(*row)
        block_given ? yield(value) : value
      end
    end

    def format_keys(keys)
      if keys.blank?
        [column_names, column_names]
      else
        [
          keys,
          keys.map do |k|
            case k
            when String
              k.split(/ as /i)[-1]
            when Symbol
              k.to_s
            end
          end
        ]
      end
    end

    alias_method :pluck_h, :pluck_to_hash
    alias_method :pluck_s, :pluck_to_struct
  end
end

ActiveRecord::Base.send(:include, PluckToHash)
