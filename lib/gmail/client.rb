module Gmail
  class Client
    def initialize(option = {})
      @mail = Mail.new.tap do |mail|
        mail.charset = 'utf-8'
        mail.delivery_method :smtp, default_option.merge(option)
      end
    end

    def deliver(from: 'project.livehouse@gmail.com', to:, body:, subject:, file:)
      @mail.from from
      @mail.to to
      @mail.body body
      @mail.subject subject
      @mail.add_file file.to_s
      @mail.deliver
    end

    private

    def default_option
      {
        address:              'smtp.gmail.com',
        port:                 587,
        domain:               'smtp.gmail.com',
        user_name:            'project.livehouse@gmail.com',
        password:             ENV['GMAIL_PASSWORD'],
        authentication:       :plain,
        enable_starttls_auto: true
      }
    end
  end
end
