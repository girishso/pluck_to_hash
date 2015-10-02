require_relative "./pluck_to_hash/version"

module PluckToHash
  extend ActiveSupport::Concern

  module ClassMethods
    def pluck_to_hash(*keys)
      # http://stackoverflow.com/questions/25331778/getting-typed-results-from-activerecord-raw-sql#answer-30948357
      @type_map ||= PG::BasicTypeMapForResults.new(connection.raw_connection)
      sql = select(*keys).to_sql
      results = connection.execute(sql)
      results.type_map = @type_map
      results
    end

    alias_method :pluck_h, :pluck_to_hash
  end
end

ActiveRecord::Base.send(:include, PluckToHash)
