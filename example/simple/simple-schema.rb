# data fields schema
table.define do
  field :number, :int
  field :char, :symbol
end

# query schema bthat named "number_to_char"
query.define(:number_to_char) do
  input :number
  output :char
end

# query schema that named "char_to_number"
query.define(:char_to_number) do
  input :char
  output :number
end
