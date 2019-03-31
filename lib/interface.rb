require_relative 'scraper.rb'
require 'pry'
class CLI

  attr_reader :item_array

  def initialize
    @item_array = Scraper.compile_list
  end

  def run
    input = ""

    puts "There are currently #{@item_array.length} items in Warframe."
    puts "It's not your fault you can't remember them all..."
    puts "To find an item, please enter the first few letters."
    puts "To exit, type 'exit' at any time."
    input = gets.strip
    while input != 'exit'
      display_array = []

      @item_array.each do |item|
        display_array << item if item.name.downcase.start_with?(input)
      end

      if display_array.length > 0
        display_array.each_with_index{|item, index| puts "#{index + 1} - #{item.name}"}
      else
        puts "Your search had no results."
      end

      puts "\n\nEnter an item number for more information or a few letters for a new search."
      input = gets.strip
    end
  end

end
