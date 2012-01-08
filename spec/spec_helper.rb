$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'xem'
require 'mocha'
require 'gl'
require 'glfw'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# open window once
Xem::Xem.instance.show

RSpec.configure do |config|
  config.mock_with :mocha
  config.before(:all) do 
    @xem = Xem::Xem.instance
  end

  config.after(:all) do
    Xem::Xem.instance.shutdown
  end
end
