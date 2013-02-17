require 'csv'
require 'date'

require 'table-query/field'
require 'table-query/query'
require 'table-query/type'
require 'table-query/table-schema'
require 'table-query/query-schema'
require 'table-query/schema-loader'
require 'table-query/table'

# TableQuery provides table definition schema and the query.
# You can get table data by easy way.
module TableQuery
  # Create a table.
  #
  # @param path [String]
  #   table data file path
  # @param options [Hash]
  #   table options
  # @return [Table]
  #   table
  def self.table(path, options={})
    Table.new(path, options)
  end
end
