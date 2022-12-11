# frozen_string_literal: true

module Arel
  module Nodes
    class ContainsArray < Arel::Nodes::Binary
      def operator
        :"@>"
      end

      alias operand1 left
      alias operand2 right
    end
  end

  module Predications
    def contains_array(other)
      Nodes::ContainsArray.new(self, quoted_node(other))
    end
  end

  module Visitors
    class PostgreSQL
      private

      # rubocop:disable Naming/MethodName
      # rubocop:disable Naming/UncommunicativeMethodParamName
      def visit_Arel_Nodes_ContainsArray(o, collector)
        # rubocop:enable Naming/MethodName
        # rubocop:enable Naming/UncommunicativeMethodParamName
        infix_value(o, collector, " @> ")
      end
    end
  end
end
