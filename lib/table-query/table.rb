module TableQuery
  # Table is a class for loading table data/schema files and providing
  # interfaces for query.
  class Table
    # table field type list
    attr_reader :types

    # table schema
    attr_reader :table_schema

    # table query schema list
    attr_reader :query_schemas

    # @api private
    attr_reader :csv

    # Create a new table.
    #
    # @param path [String]
    #   table data file path
    # @param options [Hash]
    #   table options
    def initialize(path, options={})
      @path = path
      @csv = CSV.read(path)

      eval_schema_file
      setup_query_schemas
    end

    # Return schema filename.
    #
    # @return [String]
    #   schema filename
    def schema_path
      name = "%s-schema.rb" % File.basename(@path, ".*")
      File.join(File.dirname(@path), name)
    end

    private

    # Evaluate schema file.
    def eval_schema_file
      src = File.read(schema_path)
      types, @table_schema, @query_schemas = SchemaLoader.load(src, schema_path)
      standard_types = Hash[STANDARD_TYPES.map{|type| [type.name, type]}]
      @types = standard_types.merge(types)
    end

    # Setup query schemas to access the table.
    def setup_query_schemas
      @query_schemas.each do |name, schema|
        schema.set_table self
        singleton = class << self; self; end
        singleton.send(:define_method, name) do |*vals|
          Query.new(self, schema, vals)
        end
      end
    end
  end
end
