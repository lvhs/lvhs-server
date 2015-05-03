module VideoManager

  MASTER = {
    31  => '119689095',
    61  => '119689818',
    71  => '119453209',
    91  => '119331433',
    111 => '119759975',
    121 => '119760509',
    131 => '119760321',
    151 => '119453208',
    161 => '125331375',
    171 => '125331376',
    181 => '125331377',
    191 => '125334173',
    201 => '125535038',
    211 => '125994995',
    231 => '126273196',
    221 => '126273593',
    241 => '126458562',
    251 => '126754873',
  }

  class << self
    def vid(id)
      MASTER[id]
    end
  end
end
