# Be sure to restart your server when you modify this file.
Lvhs::Application.config.session_store(:cookie_store,
                                       key: Rails.env.production? ? '_lvhs_session' : (ENV['SESSION_KEY'] || "_lvhs_session_#{Rails.env}"),
                                       domain: :all
                                      )
