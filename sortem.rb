file_name = ARGV[0]

raise ArgumentError unless file_name

class Sortem
  attr_reader :users

  def initialize(users)
    @users = users.map {|u| User.new(*u)}
  end

  def result(type_1, type_2)
    results = []
    single_set(type_2).each do |item|
      matches = users.map {|u| u if u.send(type_2) == item}.compact
      if matches.map {|match| match.send(type_1) }.uniq.count > 1
        results << matches.map(&:to_a)
      end
    end
    results
  end


  # def result
  #   results = []
  #   eins.each do |ein|
  #     matches = users.map {|u| u if u.ein == ein}.compact
  #     if matches.map(&:user).uniq.count > 1
  #       results << matches.map(&:to_a)
  #     end
  #   end
  #   results
  # end

  def single_set(type)
    users.map {|users| users.send(type) }.uniq
  end

  class User
    attr_reader :system, :name, :ein, :text, :extra_text

    def initialize(system, name, ein, text, extra_text)
      @system = system
      @name = name
      @ein = ein
      @text = text
      @extra_text = extra_text
    end

    def to_a
      [system, name, ein, text, extra_text]
    end
  end
end

require 'csv'

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
