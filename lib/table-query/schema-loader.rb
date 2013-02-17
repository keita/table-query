module TableQuery
  # SchemaLoader provides functions to load schema file and evaluation context.
  class SchemaLoader
    # VariableType is a class for +type+ special variable.
    # @api private
    class VariableType
      attr_reader :value

      def initialize
        @value = {}
      end

      def define(name, &b)
        @value[name] = Type.define(name, &b)
      end
    end

    # VariableTable is a class for +table+ special variable.
    # @api private
    class VariableTable
      attr_reader :value

      def define(&b)
        @value = TableSchema.define(&b)
      end
    end

    # VariableQuery is a class for +query+ special variable.
    # @api private
    class VariableQuery
      attr_reader :value

      def initialize
        @value = {}
      end

      def define(name, &b)
        @value[name] = QuerySchema.define(name, &b)
      end
    end

    # Evaluation context for schema definition.
    class Context
      attr_reader :type
      attr_reader :table
      attr_reader :query

      # Create a context.
      def initialize
        @type = VariableType.new
        @table = VariableTable.new
        @query = VariableQuery.new
      end

      # Return the context binding.
      def binding
        Kernel.binding
      end
    end

    # Load schema file and evaluate.
    #
    # @param src [String]
    #   schema source
    # @param filename [String]
    #   filename
    def self.load(src, filename)
      new(src, filename).eval
    end

    # Create a new loader.
    #
    # @param src [String]
    #   schema source
    # @param filename [String]
    #   filename
    def initialize(src, filename)
      @src = src
      @filename = filename
      @context = Context.new
    end

    # Evaluate schema file.
    #
    # @return [Array<Array<Type>, TableSchema, Array<QuerySchema>>]
    #   schema contents
    def eval
      @context.binding.eval(@src, @filename)
      [@context.type.value, @context.table.value, @context.query.value]
    end
  end
end
