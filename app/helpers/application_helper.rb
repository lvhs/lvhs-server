module ApplicationHelper
  def static_host
    Settings.static_host
  end

  def static_url(path)
    [static_host, path.gsub(/^\//, '')].join('/') unless path.nil?
  end
end
