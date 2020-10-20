class Server
  attr_reader :server
  def initialize
    @server = TCPServer.new 5000
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

  def reveal_integers(arr)
    arr.map { |val| val.match?(/\A\d+\z/) ? val.to_i : val }
  end

  def cost(pc_params)
    price = CSV.open('02_ruby_prices.csv').map { |item| reveal_integers(item) }

    cpu_price      = price[0][1]
    ram_price      = price[1][1]
    hdd_type_price = price.detect{ |price| price[0] == pc_params[:hdd_type] }.last

    cost = pc_params[:cpu].to_i          * cpu_price +
           pc_params[:ram].to_i          * ram_price +
           pc_params[:hdd_capacity].to_i * hdd_type_price

    # Переводим цену в рубли
    cost = cost / 100
  end
end