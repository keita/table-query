require 'table-query'
include TableQuery

describe 'TableQuery::Query' do
  table = TableQuery.table(File.join(File.dirname(__FILE__), "table", "calendar.csv"))
  query_schema = table.query_schemas[:wday_to_day]

  it 'should get the table' do
    Query.new(table, query_schema, [2, :sun]).table.should == table
  end

  it 'should get the query schema' do
    Query.new(table, query_schema, [2, :sun]).query_schema.should == query_schema
  end

  it 'should get the values' do
    Query.new(table, query_schema, [2, :sun]).values.should == [2, :sun]
  end

  it 'should get an enumerator' do
    Query.new(table, query_schema, [2, :sun]).each.should.kind_of(Enumerator)
  end

  it 'should iterate' do
    list = [3, 10, 17, 24]
    Query.new(table, query_schema, [2, :sun]).each do |day|
      list.delete(day).should.not.nil
    end
    list.should.empty
  end

  it 'should get entries' do
    Query.new(table, query_schema, [2, :sun]).entries.should == [3, 10, 17, 24]
  end
end
