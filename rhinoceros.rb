f = File.new("./CSV.csv", "r")
data = f.read
f.close

data_array = data.split("\n")
firstrow = data_array.shift

sum = 0
data_array.each do |x|
  data_split1 = x.split(",")
  data_value = data_split1[3].to_f

  sum = sum + data_value
end

average_rainfall = "#{sum/2068}"
puts "The average rainfall in CT is #{average_rainfall} hundredths of an inch per hour."


almoststandarddev = 0
data_array.each do |y|
  data_split2 = y.split(",")
  data_value2 = data_split2[3].to_f

  mid = (data_value2 - "#{average_rainfall}".to_f)**2

  almoststandarddev = almoststandarddev + mid

end

puts "The standard deviation of rainfall in CT is #{(almoststandarddev/2068)**0.5} hundredths of an inch per hour."



zscore = []
data_array.each do |z|
  data_split3 = z.split(",")
  data_value3 = data_split3[3].to_f

  mid = (data_value3 - "#{average_rainfall}".to_f) / "#{(almoststandarddev/2068)**0.5}".to_f

  zscore.push mid

end

puts "The Z-scores for each of the data points are: #{zscore}"


lines = data_array
zscores = zscore
finalarray = []


2069.times do |i|
  finalarray.push(lines[i].to_s + "," + zscores[i].to_s)

end

finalarray.unshift(firstrow)
puts finalarray


f = File.new("./NewCSV.csv", "w")
data = f.write(finalarray.join("\n"))
f.close