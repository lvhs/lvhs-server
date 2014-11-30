module ActiveAdmin
  module DomainRestriction
    extend ActiveSupport::Concern

    included do
      prepend_before_filter :restrict_to_ope_domain
      before_filter :ja_title
    end

    private

    def restrict_to_ope_domain
      if Rails.env.production? && request.subdomain != 'ope'
        render_404
      end
    end

    def ja_title
      @page_title = 'hoge'
    end
  end
end
