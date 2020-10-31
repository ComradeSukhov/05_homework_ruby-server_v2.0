require_relative 'classes/csv_reader'
require_relative 'classes/vm'
require_relative 'classes/cost_manager'
require_relative 'classes/response_controller'
require_relative 'classes/server'
require_relative 'classes/request_reader'

server = Server.new(3001).raise_session
