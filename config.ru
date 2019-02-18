require_relative 'time_app'

routes = {
  '/time' => TimeApp.new
}

use Rack::Reloader
run Rack::URLMap.new(routes)
