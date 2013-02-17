# table-query

table-query is a Ruby library to query table data by easy way.

## Install

You can install table-query by gem:

    gem install table-query

Or checkout from github:

    git clone git://github.com/keita/table-query.git

## Example

table-query consists by table data(CSV format) and the schema(written in Ruby DSL) file.
For example, simple.csv is:

    1,a
    1,b
    1,c
    2,a
    2,c
    3,b

And the schema file(simple-schema.rb):

    # data fields schema
    table.define do
      field :number, :int
      field :char, :symbol
    end
    
    # query schema that named "number_to_char"
    query.define(:number_to_char) do
      input :number
      output :char
    end
    
    # query schema that named "char_to_number"
    query.define(:char_to_number) do
      input :char
      output :number
    end

Now we can query table data by number or char like following:

    table = TableQuery.table("simple.csv")
    table.number_to_char(1).entries  # => [:a, :b, :c]
    table.char_to_number(:b).entries # => [1, 3]

## API

[API document is on github.](http://keita.github.com/table-query/api/frames.html)

## Todo

* search tool
* compile tool(generator from csv to ruby code)

## Licence

table-query is free software distributed under MIT licence.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
