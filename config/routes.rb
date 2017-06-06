Lvhs::Application.routes.draw do
  root 'teaser/announce#index'
  match '*path', controller: 'teaser/announce', action: :index, via: :get
end
