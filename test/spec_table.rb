require 'table-query'
include TableQuery

describe 'TableQuery::Table' do
  path = File.join(File.dirname(__FILE__), "table", "alphabet.csv")

  it 'should get types' do
    Table.new(path).types.map{|_, t| t.name}.should ==
      STANDARD_TYPES.map{|t| t.name}
  end

  it 'should get table schema' do
    Table.new(path).table_schema.should.kind_of TableSchema
  end

  it 'should get query schemas' do
    Table.new(path).query_schemas.map{|_, schema| schema.name}
      .should == [:number_to_char, :char_to_number]
  end

  it 'should get queries' do
    Table.new(path).number_to_char.should.kind_of Query
    Table.new(path).char_to_number.should.kind_of Query
  end
end


