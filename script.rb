require 'csv'
require_relative 'sortem'

file_name = ARGV[0]

raise ArgumentError.new("You need a filename to input: ruby script.rb name_of_csv_file.csv") unless file_name

csv = CSV.read('slim.csv')
ein_sorted = Sortem.new(csv).result('ein', 'name')
name_sorted = Sortem.new(csv).result('name', 'ein')

CSV.open("results_name.csv", "w") do |c|
  name_sorted.each do |row|
    row.each do |set|
      c << set
    end
    c << ["","","","",""]
  end
end

CSV.open("results_ein.csv", "w") do |c|
  ein_sorted.each do |row|
    row.each do |set|
      c << set
    end
    c << ["","","","",""]
  end
end
