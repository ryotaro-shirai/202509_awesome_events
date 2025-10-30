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
    Capybara.server_host = "0.0.0.0" # test用サーバーを起動するIP see:https://github.com/teamcapybara/capybara/blob/a5b5a04d81e1138d6904e33ac176227d04aacce9/lib/capybara.rb#L98-L99
    Capybara.server_port = 9999
    Capybara.run_server = true
    Capybara.app_host = "http://#{ENV['APP_HOST']}:#{Capybara.server_port}"
    driven_by :remote_chrome
  end
end