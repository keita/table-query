module TableQuery
  # TableSchema defines table fields.
  class TableSchema
    # Define a new table schema.
    #
    # @param b [Proc]
    #   schema definition
    # @return [TableSchema]
    #   table schema
    def self.define(&b)
      new.tap {|x| x.instance_eval(&b)}
    end

    # table field list
    # @return [Array<Field>]
    attr_reader :fields

    # Create a new table schema.
    def initialize
      @fields = []
    end

    # Add a table field.
    #
    # @param name [Symbol]
    #   field name
    # @param type [Symbol]
    #   field type name
    # @return [void]
    def field(name, type)
      @fields << Field.new(name, type, @fields.size, nil, {})
    end
  end
end
