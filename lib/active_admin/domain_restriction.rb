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

    def subdomain
      request.subdomain
    end
  end
end
