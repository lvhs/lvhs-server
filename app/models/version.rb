class Version
  attr_reader(:major, :minor, :patch)

  def initialize(version)
    @major, @minor, @patch =
      version.split('.').map(&:to_i)
  end

  def <=>(other)
    return nil unless other.is_a?(Version)

    [major <=> other.major,
     minor <=> other.minor,
     patch <=> other.patch
    ].detect { |n| !n.zero? } || 0
  end
end
