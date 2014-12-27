# Be sure to restart your server when you modify this file.

Rails.application.config.session_store(:cookie_store,
                                       key: Rails.env.production? ? '_lvhs_session' : (ENV['SESSION_KEY'] || "_lvhs_session_#{Rails.env}"),
                                       domain: :all,
                                       expire_after: 1.year
                                      )
