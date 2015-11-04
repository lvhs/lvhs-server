class CA
  class Reward
    class CvPoint
      attr_reader :pid, :amount, :rate, :amount_point, :rate_point,
                  :price, :requisite_id

      def initialize(data = {})
        data = data.is_a?(Array) ? Hash[*data] : data
        data.each_pair do |k, v|
          instance_variable_set("@#{k}", v)
        end
      end
    end
  end
end
