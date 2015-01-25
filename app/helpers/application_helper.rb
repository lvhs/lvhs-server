module ApplicationHelper
  def static_host
    "http://static.lvhs.jp"
  end

  def static_url(path)
    [static_host, path.gsub(/^\//, '')].join('/') unless path.nil?
  end
end
