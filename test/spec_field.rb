require 'table-query'
include TableQuery

describe 'TableQuery::Field' do
  it 'should get name' do
    Field.new(:a, :string, 0, nil, {}).name.should == :a
  end

  it 'should get type' do
    Field.new(:a, :string, 0, nil, {}).type.should == :string
  end

  it 'should get pos' do
    Field.new(:a, :string, 0, nil, {}).pos.should == 0
  end

  it 'should get value' do
    Field.new(:a, :string, 0, nil, {}).value.should.nil
  end

  it 'should get options' do
    Field.new(:a, :string, 0, nil, {}).options.should == {}
  end
end
