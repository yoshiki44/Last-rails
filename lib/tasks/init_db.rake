# frozen_string_literal: true
# rubocop:disable all

namespace :init_db do
  desc "Initialize databases if databases aren't exist"
  task setup: :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    install_spree unless databases_exists?
  end

  desc 'Reset databases'
  task reset: :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    Rake::Task['db:drop'].execute if databases_exists?
    install_spree
  end

  def install_spree
    system 'bundle exec rails g solidus:auth:install'
    system 'bundle exec rails db:create'
    system 'bundle exec rails db:migrate'
    system 'bundle exec rails runner "[\'products\', \'taxons\', \'option_values\', \'product_option_types\', \'product_properties\', \'variants\', \'assets\'].each { |table| Spree::Sample.load_sample(table) }"'
  end

  def databases_exists?
    ActiveRecord::Base.connection
    true
  rescue ActiveRecord::NoDatabaseError
    false
  end
end