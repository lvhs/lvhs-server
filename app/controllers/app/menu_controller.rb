class App::MenuController < App::BaseController
  def index
    render json: [
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
