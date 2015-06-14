class Version
  include Comparable
  attr_reader :major, :minor, :build

  def initialize(major = 0, minor = 0, build = 0)
    @major = major
    @minor = minor
    @build = build
  end

  def to_s
    to_a.join('.')
  end

  def to_a
    [major, minor, build].compact
  end

  def <=>(version)
    to_a <=> version.to_a
  end

  def eql?(version)
    to_a.eql?(version.to_a)
  end

  class << self
    def from_s(ver)
      /^(?<major>\d+)\.(?<minor>\d+)\.(?<build>\d+)?$/ =~ ver
      new(major.to_i, minor.to_i, build.to_i)
    end
  end
end
