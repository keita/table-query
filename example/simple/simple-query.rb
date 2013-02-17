require 'table-query'

path = File.join(File.dirname(__FILE__), "simple.csv")
table = TableQuery.table(path)
p table.number_to_char(1).entries  # => [:a, :b, :c]
p table.char_to_number(:b).entries # => [1, 3]
