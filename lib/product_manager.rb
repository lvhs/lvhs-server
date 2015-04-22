module ProductManager
  MASTER = {
    71  => 'jp.lvhs.livehouse.m00000001',
    161 => 'jp.lvhs.livehouse.m00000002',
    171 => 'jp.lvhs.livehouse.m00000003',
    181 => 'jp.lvhs.livehouse.m00000004',
    191 => 'jp.lvhs.livehouse.m00000005',
    201 => 'jp.lvhs.livehouse.m00000006',
  }

  class << self
    def purchasable?(id)
      MASTER.key?(id)
    end

    def pid(id)
      MASTER[id]
    end
  end
end
