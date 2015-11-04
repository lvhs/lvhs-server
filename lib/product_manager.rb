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
    241 => 'jp.lvhs.livehouse.m00000011',
    251 => 'jp.lvhs.livehouse.m00000012',
    261 => 'jp.lvhs.livehouse.m00000013',
    291 => 'jp.lvhs.livehouse.m00000014',
    311 => 'jp.lvhs.livehouse.m00000015',
    321 => 'jp.lvhs.livehouse.m00000016',
    331 => 'jp.lvhs.livehouse.m00000017',
    341 => 'jp.lvhs.livehouse.m00000018',
    351 => 'jp.lvhs.livehouse.m00000019',
    371 => 'jp.lvhs.livehouse.m00000020',
    381 => 'jp.lvhs.livehouse.m00000021',
    391 => 'jp.lvhs.livehouse.m00000022',
    401 => 'jp.lvhs.livehouse.m00000023',
    411 => 'jp.lvhs.livehouse.m00000024',
    421 => 'jp.lvhs.livehouse.m00000025',
    431 => 'jp.lvhs.livehouse.m00000026',
    451 => 'jp.lvhs.livehouse.m00000027',
    521 => 'jp.lvhs.livehouse.m00000028',
    531 => 'jp.lvhs.livehouse.m00000029',
    541 => 'jp.lvhs.livehouse.m00000030',
    551 => 'jp.lvhs.livehouse.m00000031',
    691 => 'jp.lvhs.livehouse.m00000032',
  }

  class << self
    def purchasable?(id)
      MASTER.key?(id)
    end

    def pid(id)
      MASTER[id]
    end

    def iid(id)
      MASTER.to_a.map{|a| a.reverse }.to_h[id]
    end
  end
end
