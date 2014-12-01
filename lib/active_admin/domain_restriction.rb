module ActiveAdmin
  module DomainRestriction
    extend ActiveSupport::Concern

    included do
      prepend_before_filter :restrict_to_ope_domain
    end

    private

    def restrict_to_ope_domain
      if Rails.env.production? && subdomain != 'ope'
        render_404
      end
    end

    def heroku?
      ENV['PLATFORM'] == 'heroku'
    end

    def subdomain
      if heroku?
        request.subdomain.split(".")[1..-1].join(".")
      else
        request.subdomain
      end
    end
  end
end
