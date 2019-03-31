require_relative 'scraper.rb'
class CLI

  attr_reader :item_array

  def initialize
    @item_array = Scraper.compile_list
  end

  def run
    puts "\tThere are currently #{@item_array.length} items in Warframe."
    puts "\tIt's not your fault you can't remember them all..."
    puts "\tTo find an item, please enter the first few letters."
    puts "\tTo exit, type 'exit' at any time."

    input = gets.strip

    while input != 'exit'
      display_array = []

      @item_array.each do |item|
        display_array << item if item.name.downcase.start_with?(input)
      end

      if display_array.length > 0
        display_array.each_with_index{|item, index| puts "#{index + 1} - #{item.name}"}
      else
        puts "\tYour search had no results."
      end

      puts "\n\n\tEnter an item number for more information or a few letters for a new search."
      input = gets.strip

      if input.start_with?(/\d/)
        puts "\t#{Scraper.get_item_info(display_array[input.to_i - 1])}"
        puts "\tEnter your next search or 'exit'."
        input = gets.strip
      else
        next
      end
    end
  end

end
