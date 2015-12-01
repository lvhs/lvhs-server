class App::VersionController < App::BaseController
  def index
    render json: {
      required_version: '0.0.5', #latest_bundle_version.to_s,
      type: "force",
      update_url: Settings.app_store_url
    }
  end
end

