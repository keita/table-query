type.define(:weekday) do
  list = [:sun, :mon, :tue, :wed, :thu, :fri, :sat]
  table = Hash[list.zip((0..6).to_a)]
  to_ruby {|val| list[val.to_i]}
  from_ruby {|val| table[val].to_s}
end

table.define do
  field :year            , :int
  field :month           , :int
  field :mday            , :int
  field :wday            , :weekday
  field :national_holiday, :string
end

query.define(:wday_to_day) do
  input  :year
  input  :month
  input  :wday
  output :mday
end

query.define(:national_holiday_list) do
  output :national_holiday, :empty => :ignore
end

query.define(:fri_13th) do
  value  :mday, 13
  value  :wday, :fri
  output :year
  output :month
  output :mday
end
