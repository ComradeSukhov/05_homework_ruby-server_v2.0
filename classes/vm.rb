class VM
  attr_accessor :cpu, :ram, :hdd_type, :hdd_capacity, :addit_hdd, :cost

  def initialize(vm_conf)
    @cpu          = vm_conf[:cpu]
    @ram          = vm_conf[:ram]
    @hdd_type     = vm_conf[:hdd_type]
    @hdd_capacity = vm_conf[:hdd_capacity]
    @addit_hdd    = vm_conf[:addit_hdd]
    @cost         = nil
  end
end