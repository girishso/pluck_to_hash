# frozen_string_literal: true

require 'pluck_to_hash'

module PluckToHash
  class Railtie < Rails::Railtie
    initializer 'pluck_to_hash.initialization' do
      ActiveSupport.on_load(:active_record) { include PluckToHash }
    end
  end
end
