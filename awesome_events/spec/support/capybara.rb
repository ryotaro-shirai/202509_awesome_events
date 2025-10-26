Capybara.register_driver :remote_chrome do |app|
  url = ENV['SELENIUM_DRIVER_URL']
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')
  options.add_argument('--disable-gpu')
  options.add_argument('no-sandbox')
  options.add_argument('window-size=1680,1050')
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, capabilities: options)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    Capybara.run_server = false
    Capybara.app_host = "http://#{ENV['APP_HOST']}:#{ENV['APP_PORT']}"
    driven_by :remote_chrome
  end
end