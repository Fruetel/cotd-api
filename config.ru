$stdout.sync = $stderr.sync = true
$LOAD_PATH << File.expand_path('lib', File.dirname(__FILE__))

require 'config/initializer'
require 'app'

map '/healthz' do
  run ->(_env) { [200, { 'Content-type' => 'text/plain' }, ['Ok!']] }
end

run App.new
