namespace :js do
  desc 'Create rails-routes.js'
  task routes: :environment do
    path = Rails.root.join('app/assets/javascripts/routes.js')
    options = {
      namespace: 'Routes',
      exclude: [/^admin_/]
    }
    JsRoutes.generate!(path, options)
  end
end
