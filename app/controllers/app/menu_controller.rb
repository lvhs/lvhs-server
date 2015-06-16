class App::MenuController < App::BaseController
  def index
    render json: [
      {
        title: "掲示板",
        type: "url",
        data: "http://stage.lvhs.jp/app/events"
      },
      {
        title: "プロフィール",
        type: "url",
        data: "http://stage.lvhs.jp/app/profile"
      },
      {
        title: "シェア",
        type: "share"
      },
      {
        title: "お問い合わせ",
        type: "support"
      },
      {
        title: "購入履歴の復元",
        type: "restore"
      }
    ]
  end
end
