# frozen_string_literal: true

class ResponseController
  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def result
    price   = CsvReader.new('02_ruby_prices.csv').read_vm_prices

    vm_conf = RequestReader.new(request).result
    vm      = VM.new(vm_conf)
    vm_cost = CostManager.new(vm, price).calc_cost
  end
end
