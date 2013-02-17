table.define do
  field :number, :int
  field :char, :string
end

query.define(:number_to_char) do
  input :number
  output :char
end

query.define(:char_to_number) do
  input :char
  output :number
end
