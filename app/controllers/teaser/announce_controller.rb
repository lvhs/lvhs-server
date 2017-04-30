class Teaser::AnnounceController < Teaser::BaseController
  def index
    @no_facebook = true
    @text = <<-TEXT.strip_heredoc
    平素より弊社「LIVEHOUSE」をご利用いただき、誠にありがとうございます。

    App Storeで運営する「LIVEHOUSE」のサービスを、2017年5月31日（水）に終了いたします。

    弊社では、お客様に満足いただくために開発・運営してまいりましたが、昨今の事業環境や今後の展開を鑑みて、誠に残念ではありますが、サービスを終了させていただくことになりました。

    2015年9月の配信以来、多くのユーザーの皆様にご愛顧いただきましたことを心から感謝いたします。

    購入していただいたコンテンツに関してもサービス終了日以降、下記URLにて閲覧できるようにいたします。
    <a href="https://vimeo.com/lvhs">https://vimeo.com/lvhs</a>

    ユーザーの皆様には、ご迷惑、ご不便をおかけいたしますが、何卒ご理解いただきますよう、お願い申し上げます。

    株式会社ジャパンミュージックシステム
    support@lvhs.jp
    TEXT
  end
end
