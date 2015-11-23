class App::MenuController < App::BaseController
  def index
    domain = Rails.configuration.domain

    menu = in_review? ? [
      {
        title: 'ホーム',
        type: 'url',
        data: "http://#{domain}/app/"
      },
      {
        title: 'シェア',
        type: 'share'
      },
      {
        title: 'お問い合わせ',
        type: 'support'
      },
      {
        title: '購入履歴の復元',
        type: 'restore'
      }
    ] : [
      {
        title: 'ホーム',
        type: 'url',
        data: "http://#{domain}/app/"
      },
      {
        title: 'ライブ掲示板',
        type: 'url',
        data: "http://#{domain}/app/events"
      },
      {
        title: 'プロフィール',
        type: 'url',
        data: "http://#{domain}/app/profile"
      },
      {
        title: 'シェア',
        type: 'share'
      },
      {
        title: 'お問い合わせ',
        type: 'support'
      },
      {
        title: '購入履歴の復元',
        type: 'restore'
      }
    ]

    render json: menu
  end
end
