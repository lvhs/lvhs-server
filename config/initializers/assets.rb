# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Lvhs::Application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Lvhs::Application.config.assets.precompile += %w( search.js )
# Lvhs::Application.config.assets.precompile += %w(teaser/main.css)
Rails.application.config.assets.precompile += %w( teaser/main.css )
