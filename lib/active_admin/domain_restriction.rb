module ActiveAdmin
  module DomainRestriction
    extend ActiveSupport::Concern

    included do
      before_filter :restrict_to_ope_domain
    end

    private

    def restrict_to_ope_domain
      if Rails.env.production? && request.domain != 'ope.lvhs.jp'
        render 404
      end
    end
  end
end
