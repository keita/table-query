module TableQuery
  # QuerySchema defines query's input and output field relation.
  class QuerySchema
    # Define a new query schema.
    #
    # @param name [Symbol]
    #   query name
    # @return [QuerySchema]
    #   new query schema
    def self.define(name, &b)
      new(name).tap {|x| x.instance_eval(&b)}
    end

    # query name
    # @return [Symbol]
    attr_reader :name

    # input field list
    # @return [Array<Field>]
    attr_reader :inputs

    # output field list
    # @return [Array<Field>]
    attr_reader :outputs

    # preset value list
    # @return [Array<Field>]
    attr_reader :values

    # Create a query schema object.
    #
    # @param name [Symbol]
    #   query name
    def initialize(name)
      @name = name
      @inputs = []
      @outputs = []
      @values = []
      @table = nil
    end

    # Define an input field.
    #
    # @param name [Symbol]
    #   field name
    # @param options [Hash]
    #   input options
    # @return [void]
    def input(name, options={})
      @inputs << Field.new(name, nil, nil, nil, options)
    end

    # Define an output field.
    #
    # @param name [Symbol]
    #   field name
    # @param options [Hash]
    #   output options
    # @return [void]
    def output(name, options={})
      @outputs << Field.new(name, nil, nil, nil, options)
    end

    # Define pre set value of the query.
    #
    # @param name [Symbol]
    #   field name
    # @param val [Object]
    #   table data
    # @param options [Hash]
    #   value options
    # @return [void]
    def value(name, val, options={})
      @values << Field.new(name, nil, nil, val, options)
    end

    # Set target table for query.
    #
    # @param table [Table]
    #   query target table
    # @return [void]
    # @api private
    def set_table(table)
      @table = table
      @table.table_schema.fields.each do |field|
        (@inputs + @outputs + @values).each do |item|
          if field.name == item.name
            item.pos = field.pos
            item.type = @table.types[field.type]
          end
        end
      end
    end
  end
end

