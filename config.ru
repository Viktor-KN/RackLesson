require_relative 'time_app'

routes = {
  '/time' => TimeApp
}

use Rack::Reloader
run Rack::URLMap.new(routes)
