# # This file is copied to spec/ when you run 'rails generate rspec:install'
# require 'spec_helper'
# ENV['RAILS_ENV'] ||= 'test'
# require_relative '../config/environment'
# abort("The Rails environment is running in production mode!") if Rails.env.production?
# require 'rspec/rails'

# # Ensures that the test database schema matches the current schema file.
# begin
#   ActiveRecord::Migration.maintain_test_schema!
# rescue ActiveRecord::PendingMigrationError => e
#   abort e.to_s.strip
# end

# RSpec.configure do |config|
#   config.fixture_paths = [
#     Rails.root.join('spec/fixtures')
#   ]
#   Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

#   config.use_transactional_fixtures = true

#   config.filter_rails_from_backtrace!

#   # Warden para login manual (como login_as)
#   config.include Warden::Test::Helpers
#   config.after(:each) { Warden.test_reset! }

#   # FactoryBot
#   config.include FactoryBot::Syntax::Methods
# end

# # 🔧 CONFIGURAÇÕES CAPYBARA COM SUPORTE A SESSÃO (rack_session_access)

# # Middleware para acessar sessão nos testes
# require 'capybara/rspec'
# require 'rack_session_access/capybara'

# # Registra driver com suporte à sessão
# Capybara.register_driver :rack_test_with_session do |app|
#   Capybara::RackTest::Driver.new(app, rack_session: true)
# end

# Capybara.default_driver = :rack_test_with_session

# # Capybara.app_host = 'http://localhost:3000'
# Capybara.server = :puma, { Silent: true }
# spec/rails_helper.rb

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

# Carrega todos os arquivos da pasta 'support' (onde ficam helpers, etc.)
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.fixture_paths = [ Rails.root.join('spec/fixtures') ]

  # =============================================================================
  # ## MUDANÇA 1: DESATIVAR O USO DE TRANSACTIONS ##
  #
  # Isto é essencial para que os testes de sistema (que rodam em um navegador)
  # consigam enxergar os dados criados no banco de dados pelo teste.
  config.use_transactional_fixtures = false
  # =============================================================================

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Inclui a sintaxe do FactoryBot (create, build, etc.)
  config.include FactoryBot::Syntax::Methods

  # =============================================================================
  # ## MUDANÇA 2: CONFIGURAR O DATABASE CLEANER ##
  #
  # Esta é a estratégia moderna para garantir que o banco de dados esteja
  # limpo antes de cada teste.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # Para testes de sistema, a estratégia deve ser 'truncation',
  # pois eles rodam em um processo separado.
  config.before(:each, type: :system) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  # =============================================================================
end