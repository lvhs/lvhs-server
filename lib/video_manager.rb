module VideoManager
  MASTER = {
    151 => '119453208',
    91  => '119331433',
    31 => '119689095',
    71 => '119453209',
    111 => '119759975',
    61 => '119689818',
    121 => '119760509',
    131 => '119760321',
  }

  class << self
    def vid(id)
      MASTER[id]
    end
  end
end
