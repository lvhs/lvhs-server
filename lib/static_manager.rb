module StaticManager
  MASTER = {
    126754873 => 518984726,
    126273196 => 516652653,
    126273593 => 516653210,
    126458562 => 516907305,
  }

  class << self
    def thumb_id(id)
      MASTER[id.to_i] || id
    end
  end
end
