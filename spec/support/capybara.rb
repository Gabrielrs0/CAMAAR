require 'capybara/rspec'

# Define o driver do navegador a ser usado.
# Esta configuração garante que o Chrome rode em modo "headless" (sem interface).
Capybara.register_driver :selenium_chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless=new')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-gpu')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Define o servidor que o Capybara usará para rodar sua aplicação de teste.
Capybara.server = :puma, { Silent: true }

# Configura o RSpec para usar o driver de navegador que acabamos de registrar
# em todos os testes do tipo `system`.
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end
end
