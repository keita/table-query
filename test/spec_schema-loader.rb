require 'table-query'
include TableQuery

describe 'TableQuery::SchemaLoader' do
  path = File.join(File.dirname(__FILE__), "table", "alphabet-schema.rb")

  it 'should load a schema' do
    types, table_schema, query_schemas =
      SchemaLoader.load(File.read(path), path)
    types.should.empty
    table_schema.should.kind_of TableSchema
    query_schemas.map{|_, schema| schema.name}
      .should == [:number_to_char, :char_to_number]
  end
end
