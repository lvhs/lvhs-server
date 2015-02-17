module ActiveAdmin
  module Views
    class TableFor
      def bool_column(attribute)
        column(attribute) { |model| model[attribute] ? 'Yes' : '-' }
      end

      def date_column(attribute)
        column(attribute) { |model| model[attribute].strftime('%Y年%m月%d日 %H:%M:%S') }
      end
    end

    class AttributesTable
      def bool_row(attribute)
        row(attribute) { |model| model[attribute] ? '✔'.html_safe : '✗'.html_safe }
      end
    end
  end
end
