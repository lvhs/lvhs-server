module Routes
  module Constraints
    class Subdomain
      def initialize(subdomain)
        @subdomain = subdomain
      end

      def matches?(request)
        !Rails.env.production? ||
          (request.subdomain.present? && request.subdomain == @subdomain)
      end

      NAMES = %w(api app ope)
      NAMES.each { |name| self.const_set(name.upcase, self.new(name)) }
    end
  end
end
