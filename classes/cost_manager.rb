class CostManager
  attr_accessor :data, :prices  

  def initialize(data, price)
    @data   = data
    @prices = price
  end

  def set_cost
    if @data.class == Array
      @data.each { |vm| vm.cost = calc_cost(vm) }
    else
      @data.cost = calc_cost(vm)
    end
  end

  def calc_cost(vm = @data)
    cpu_price = find_price('cpu')
    ram_price = find_price('ram')
    hdd_price = find_price(vm.hdd_type)

    cpu_cost     = cpu_price * vm.cpu
    ram_cost     = ram_price * vm.ram
    hdd_cost     = hdd_price * vm.hdd_capacity
    add_hdd_cost = clac_add_hdd(vm)

    cost = cpu_cost + ram_cost + hdd_cost + add_hdd_cost

    # Изначально цены установленны в копейках. Приводим цену к рублевому эквиваленту
    cost / 100
  end

  def find_price(incoming_price_name)
    found_price = @prices.select do |price|
                    price_name = price.select { |parametr| parametr.class == String }[0]
                    price_name == incoming_price_name
                  end

    # Во втором элементе массива ожидаем стоимость. В первом лежит имя товара
    found_price[0][1]
  end

  def clac_add_hdd(vm)
    add_hdd_cost = vm.addit_hdd.map do |hdd|
                        hdd_type     = hdd[:hdd_type]
                        hdd_capacity = hdd[:hdd_capacity]

                        hdd_capacity * find_price(hdd_type)
                      end
    add_hdd_cost.sum
  end
end