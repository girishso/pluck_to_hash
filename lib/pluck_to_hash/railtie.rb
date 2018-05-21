# frozen_string_literal: true

module PluckToHash
  class Railtie < Rails::Railtie
    initializer 'pluck_to_hash.initialization' do
      ActiveSupport.on_load(:active_record) {
        require 'pluck_to_hash/pluck_to_concern'
        include PluckToConcern
      }
    end
  end
end
