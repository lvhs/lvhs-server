module ProductManager

  MASTER = {
    71  => 'jp.lvhs.livehouse.m00000001',
    161 => 'jp.lvhs.livehouse.m00000002',
    171 => 'jp.lvhs.livehouse.m00000003',
    181 => 'jp.lvhs.livehouse.m00000004',
    191 => 'jp.lvhs.livehouse.m00000007',
    201 => 'jp.lvhs.livehouse.m00000006',
    211 => 'jp.lvhs.livehouse.m00000008',
    231 => 'jp.lvhs.livehouse.m00000009',
    221 => 'jp.lvhs.livehouse.m00000010',
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
