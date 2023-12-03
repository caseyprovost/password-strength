Capybara.disable_animation = true
Capybara.server = :puma
Capybara::Lockstep.debug = false

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Options.chrome(
    :args => %w[
      --headless
      --no-sandbox
      --disable-gpu
      --disable-dev-shm-usage
      --window-size=2920,4080
      --force-device-scale-factor=1
      --font-render-hinting=none
    ],
    "goog:loggingPrefs" => {browser: "ALL"}
  )

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.configure do |config|
  config.automatic_label_click = true
  config.default_max_wait_time = 5 # seconds
  config.default_driver = :selenium_chrome_headless
  config.disable_animation = true
  config.ignore_hidden_elements = true
  config.test_id = "data-test-id"
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end
end
