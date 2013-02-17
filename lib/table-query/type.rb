module TableQuery
  # Type is a class for data conversion.
  class Type
    # Define new type with the block.
    #
    # @return [Type]
    #   type object
    def self.define(name, &b)
      new(name).tap {|x| x.instance_eval(&b)}
    end

    # Return the type name.
    attr_reader :name

    # Create new type.
    #
    # @param name [Symbol]
    #   type name
    def initialize(name)
      @name = name
    end

    # Define a converter data to ruby object.
    #
    # @param b [Proc]
    #   table data to ruby object converter
    # @return [void]
    def to_ruby(&b)
      @to_ruby = b
    end

    # Define a converter ruby object to data.
    #
    # @param b [Proc]
    #   ruby object to table data converter
    # @return [void]
    def from_ruby(&b)
      @from_ruby = b
    end

    # Convert the data to ruby object.
    #
    # @param val [String]
    #   the data
    # @return [Object]
    #   ruby object
    def convert_to_ruby(val)
      @to_ruby.call(val)
    end

    # Convert the ruby object to data.
    #
    # @param val [Object]
    #   ruby object
    # @return [String]
    #   data
    def convert_from_ruby(val)
      @from_ruby.call(val)
    end

    # field type +bool+
    BOOL = Type.define(:bool) {
      to_ruby {|val| val == "true"}
      from_ruby {|val| val.to_s}
    }

    # field type +int+
    INT = Type.define(:int) {
      to_ruby {|val| val.to_i}
      from_ruby {|val| val.to_s}
    }

    # field type +float+
    FLOAT = Type.define(:float) {
      to_ruby {|val| val.to_f}
      from_ruby {|val| val.to_s}
    }

    # field type +string+
    STRING = Type.define(:string) {
      to_ruby {|val| val}
      from_ruby {|val| val.to_s}
    }

    # field type +symbol+
    SYMBOL = Type.define(:symbol) {
      to_ruby {|val| val.to_sym}
      from_ruby {|val| val.to_s}
    }

    # field type +time+
    TIME = Type.define(:time) {
      to_ruby {|val| DateTime.parse(val)}
      from_ruby {|val| val.strftime("%Y-%m-%d %H:%M:%S")}
    }

    # field type +date+
    DATE = Type.define(:date) {
      to_ruby {|val| Date.parse(val)}
      from_ruby {|val| val.strftime("%Y-%m-%d")}
    }
  end

  # standard type list that includes
  # - bool
  # - int
  # - float
  # - string
  # - symbol
  # - time
  # - date
  STANDARD_TYPES = [
    Type::BOOL,
    Type::INT,
    Type::FLOAT,
    Type::STRING,
    Type::SYMBOL,
    Type::TIME,
    Type::DATE
  ]
end
