class RequestReader
  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def result
    result = {
               cpu: @request.match(/cpu=(\d+)/)[1].to_i,
               ram: @request.match(/ram=(\d+)/)[1].to_i,
          hdd_type: @request.match(/hdd_type=(\w+)/)[1],
      hdd_capacity: @request.match(/hdd_capacity=(\d+)/)[1].to_i,
         addit_hdd: addit_hdd 
    }

    result
  end

  # Метод ищет в запросе конфигурации дополнительных дисков
  # и составляет из них массив хэшев
  def addit_hdd
    # Пример строчки которая подходит под регулярное выражение:
    # disks[]=sata&disks[]=32
    disks = @request.scan(/disks\[\]=(\d+|\w+)&disks\[\]=(\d+|\w+)/)
    return [] if disks == nil

    # Преобразуем двумерный массив таким образом, что бы каждый подмассив был хэшем
    # с ключами type и capacity
    disks.map! do |disk|
      new_disk = {}
      new_disk[:type]     = disk.select { |elem| elem.match(/[a-z]+/) }[0]
      new_disk[:capacity] = disk.select { |elem| elem.match(/\d+/) }[0].to_i

      new_disk
    end
    
     disks
  end

end