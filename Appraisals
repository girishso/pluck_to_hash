# frozen_string_literal: true

%w[4.0 4.1 4.2 5.0 5.1].each do |rails_version|
  appraise "rails-#{rails_version}" do
    gem 'activerecord', "~> #{rails_version}.0"
    gem 'activesupport', "~> #{rails_version}.0"
  end
end