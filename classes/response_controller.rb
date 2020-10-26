class ResponseController
  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def result
    price   = CsvReader.new('02_ruby_prices.csv').read
    
    vm_conf = RequestReader.new(request).result
    vm      = VM.new(vm_conf)
    vm_cost = CostManager.new(vm, price).calc_cost
  end
end