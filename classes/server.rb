class Server
  attr_reader :server
  def initialize(port = 5000)
    @server = TCPServer.new port
  end

  def raise_session
    while session = server.accept

    request   = session.gets
    pc_params = to_parse_pc_params(request)

    session.print "HTTP/1.1 200\r\n"
    session.print "Content-Type: text/html\r\n"
    session.print "\r\n"
    session.print "Цена ВМ составляет: #{cost(pc_params)} руб."

    session.close
    end
  end

  private

  def to_parse_pc_params(request)
    request.match(/\?cpu=(?<cpu>\d*),ram=(?<ram>\d*),hdd_type=(?<hdd_type>\w*),hdd_capacity=(?<hdd_capacity>\d*)/)
  end

end