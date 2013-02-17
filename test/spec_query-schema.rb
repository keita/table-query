require 'table-query'
include TableQuery

describe 'TableQuery::QuerySchema' do
  it 'should define a query schema' do
    QuerySchema.define(:test) do
      input :a
      output :b
    end.should.kind_of QuerySchema
  end

  it 'should get the query name' do
    QuerySchema.define(:test) do
      input :a
      output :b
    end.name.should == :test
  end

  it 'should input fields' do
    QuerySchema.define(:test) do
      input :a
      input :b
      input :c
    end.inputs.map{|f| f.name}.should == [:a, :b, :c]
  end

  it 'should output fields' do
    QuerySchema.define(:test) do
      output :a
      output :b
      output :c
    end.outputs.map{|f| f.name}.should == [:a, :b, :c]
  end

  it 'should value fields' do
    QuerySchema.define(:test) do
      value :a, 1
      value :b, 2
      value :c, 3
    end.values.map{|f| f.name}.should == [:a, :b, :c]
  end
end
