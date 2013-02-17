require 'table-query'
include TableQuery

describe 'TableQuery::TableSchema' do
  it 'should define a table schema' do
    TableSchema.define do
      field :a, :string
    end.should.kind_of TableSchema
  end

  it 'should get table fields' do
    TableSchema.define do
      field :a, :string
      field :b, :int
      field :c, :bool
    end.fields.map{|f| f.name}.should == [:a, :b, :c]
  end
end
