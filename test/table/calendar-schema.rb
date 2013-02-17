type.define(:weekday) do
  list = [:sun, :mon, :tue, :wed, :thu, :fri, :sat]
  table = Hash[list.zip((0..6).to_a)]
  to_ruby {|val| list[val.to_i]}
  from_ruby {|val| table[val].to_s}
end

table.define do
  field :year , :int
  field :month, :int
  field :mday , :int
  field :wday , :weekday
end

query.define(:wday_to_day) do
  input  :month
  input  :wday
  output :mday
end

query.define(:month_of_year) do
  input :year
  output :month
end

query.define(:day_of_month) do
  input :month
  output :mday
end
