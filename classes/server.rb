require 'socket'
require 'json'

class Server
  attr_reader :server

  def initialize(port = 5000)
    @server = TCPServer.new port
  end

  def raise_session
    while session = server.accept

    request   = session.gets
    cost      = ResponseController.new(request).result

    session.print "HTTP/1.1 200\r\n"
    session.print "Content-Type: application/json\r\n"
    session.print "\r\n"
    session.print({cost: cost}.to_json)

    session.close
    end
  end
end