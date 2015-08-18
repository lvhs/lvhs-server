module StaticManager
  MASTER = {
    126754873 => 518984726,
    126273196 => 516652653,
    126273593 => 516653210,
    126458562 => 516907305,
    125535038 => 515668030,
    125994995 => 516287740,
    125334173 => 515399001,
    125331377 => 515397437,
    125331376 => 515396847,
    125331375 => 515395160,
    127391192 => 518981109,
    128338279 => 519432505,
    128338366 => 519433008,
    128661854 => 519876038,
    128751461 => 519992682,
    129454645 => 520942805,
    130168859 => 521922295,
    130287321 => 522088016,
    130520127 => 522411544,
    130849095 => 522863234,
    131849304 => 524268673,
    132068919 => 524566991,
    132071380 => 524569930,
    132698227 => 525467963,
    132698228 => 525468055,
    132802473 => 525618009,
    132802472 => 525618020,
    132802474 => 525618004,
    133130325 => 526086406,
    135722027 => 529902681,
    135654430 => 529777844,
    136574710 => 531133275,
    136572140 => 531128932,
  }

  class << self
    def thumb_id(id)
      MASTER[id.to_i] || id
    end
  end
end
