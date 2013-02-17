module TableQuery
  # Query is a class for providing query interfaces. This is enumerable, so you
  # can access results by various enumeration methods.
  class Query
    include Enumerable

    # target table
    # @return [Table]
    attr_reader :table

    # query schema
    # @return [QuerySchema]
    attr_reader :query_schema

    # query values
    # @return [Array<Object>]
    attr_reader :values

    # Create a query interface.
    def initialize(table, query_schema, vals)
      @table = table
      @query_schema = query_schema
      @values = vals
    end

    # This is an enumeration method. If block is not given, then return an
    # +Enumerator+ object.
    def each
      if block_given?
        vals = []
        @query_schema.inputs.each_with_index do |input, i|
          vals << input.type.convert_from_ruby(@values[i])
        end
        @table.csv.each do |row|
          if @query_schema.inputs.zip(vals).all? {|input, val| row[input.pos] == val} and
              @query_schema.values.all? {|value| row[value.pos] == value.type.convert_from_ruby(value.value)}
            outputs = []
            cond = @query_schema.outputs.each do |output|
              val = row[output.pos]
              if output.options[:empty] == :ignore and val == ""
                break :break
              else
                outputs << output.type.convert_to_ruby(val)
              end
            end
            yield *outputs unless cond == :break
          end
        end
      else
        return Enumerator.new(self)
      end
    end
  end
end
