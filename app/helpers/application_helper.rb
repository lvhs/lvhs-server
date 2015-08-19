module ApplicationHelper
  def static_host
    Settings.static_host
  end

  def static_url(path)
    [static_host, path.gsub(/^\//, '')].join('/') unless path.nil?
  end

  def user_agent
    @user_agent ||= Woothee.parse(request.user_agent)
  end

  def smartphone?
    user_agent[:category] == :smartphone
  end
end
