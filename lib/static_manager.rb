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
    128338279 => 519432505,
    128338366 => 519433008,
  }

  class << self
    def thumb_id(id)
      MASTER[id.to_i] || id
    end
  end
end
