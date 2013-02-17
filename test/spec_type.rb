require 'table-query'
include TableQuery

describe 'TableQuery::Type' do
  it 'should get type name' do
    Type::BOOL.name.should == :bool
  end

  describe 'BOOL' do
    it 'should convert to ruby object' do
      Type::BOOL.convert_to_ruby("true").should == true
      Type::BOOL.convert_to_ruby("false").should == false
    end

    it 'should convert from ruby object' do
      Type::BOOL.convert_from_ruby(true).should == "true"
      Type::BOOL.convert_from_ruby(false).should == "false"
    end
  end

  describe 'INT' do
    it 'should convert to ruby object' do
      Type::INT.convert_to_ruby("123").should == 123
      Type::INT.convert_to_ruby("-123").should == -123
    end

    it 'should convert from ruby object' do
      Type::INT.convert_from_ruby(123).should == "123"
      Type::INT.convert_from_ruby(-123).should == "-123"
    end
  end

  describe 'FLOAT' do
    it 'should convert to ruby object' do
      Type::FLOAT.convert_to_ruby("0.123").should == 0.123
      Type::FLOAT.convert_to_ruby("-0.123").should == -0.123
    end

    it 'should convert from ruby object' do
      Type::FLOAT.convert_from_ruby(0.123).should == "0.123"
      Type::FLOAT.convert_from_ruby(-0.123).should == "-0.123"
    end
  end

  describe 'STRING' do
    it 'should convert to ruby object' do
      Type::STRING.convert_to_ruby("abc").should == "abc"
    end

    it 'should convert from ruby object' do
      Type::STRING.convert_from_ruby("abc").should == "abc"
    end
  end

  describe 'SYMBOL' do
    it 'should convert to ruby object' do
      Type::SYMBOL.convert_to_ruby("abc").should == :abc
    end

    it 'should convert from ruby object' do
      Type::SYMBOL.convert_from_ruby(:abc).should == "abc"
    end
  end

  describe 'TIME' do
    it 'should convert to ruby object' do
      Type::TIME.convert_to_ruby("2013-2-17 13:12:56").tap do |x|
        x.year.should == 2013
        x.month.should == 2
        x.mday.should == 17
        x.hour.should == 13
        x.min.should == 12
        x.sec.should == 56
      end
    end

    it 'should convert from ruby object' do
      Type::TIME.convert_from_ruby(DateTime.parse("2013-2-17 13:12:56"))
        .should == "2013-02-17 13:12:56"
    end
  end

  describe 'DATE' do
    it 'should convert to ruby object' do
      Type::DATE.convert_to_ruby("2013-2-17").tap do |x|
        x.year.should == 2013
        x.month.should == 2
        x.mday.should == 17
      end
    end

    it 'should convert from ruby object' do
      Type::DATE.convert_from_ruby(Date.parse("2013-2-17"))
        .should == "2013-02-17"
    end
  end
end
