require 'table-query'

path = File.join(File.dirname(__FILE__), "calendar-jp.csv")
table = TableQuery.table(path)

puts "Monday of Feb 2013"
puts "------------------"
puts table.wday_to_day(2013, 2, :mon).entries.join(", ")

puts "\nNational holiday list"
puts "---------------------"
table.national_holiday_list.each do |holiday|
  puts holiday
end

puts "\nFind Friday the 13th in 2013"
puts "----------------------------"
table.fri_13th.each do |year, month, mday|
  puts "%d/%d/%d" % [year, month, mday]
end
