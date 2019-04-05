require_relative 'scraper.rb'
class CLI

  attr_reader :item_array

  def initialize
    @item_array = Scraper.compile_list
  end

  def search(key)
    results = []
    @item_array.each do |item|
      results << item if item.name.downcase.start_with?(key)
    end
    results
  end

  def process_results(results)
    if results.length > 0
      results.each_with_index{|item, index| puts "#{index + 1} - #{item.name}".blue}
    else
      puts "\tYour search had no results.".red
    end
  end

  def run
    puts "\t                 /eeeeeeeeeee\\ "
    puts "\t   /RRRRRRRRRR\\ /eeeeeeeeeeeee\\ /RRRRRRRRRR\\ "
    puts "\t  /RRRRRRRRRRRR\\|eeeeeeeeeeeee|/RRRRRRRRRRRR\\ "
    puts "\t /RRRRRRRRRRRRRR +++++++++++++ RRRRRRRRRRRRRR\\ "
    puts "\t|RRRRRRRRRRRRRR ############### RRRRRRRRRRRRRR| "
    puts "\t|RRRRRRRRRRRRR ######### ####### RRRRRRRRRRRRR| "
    puts "\t \\RRRRRRRRRRR ######### ######### RRRRRRRRRR/ "
    puts "\t   |RRRRRRRRR ########## ######## RRRRRRRR| "
    puts "\t  |RRRRRRRRRR ################### RRRRRRRRR| "
    puts "\t               ######     ###### "
    puts "\t               #####       ##### "
    puts "\t               #nnn#       #nnn#"
    puts "\tThere are currently #{@item_array.length} items in Warframe.".cyan
    puts "\tIt's not your fault you can't remember them all...".cyan
    puts "\tTo find an item, please enter the first few letters.".cyan
    puts "\tTo exit, type 'exit' at any time.".cyan

    input = gets.strip

    while input != 'exit'
      results = search(input)
      process_results(results)

      puts "\n\tEnter an item number for more information or a few letters for a new search.".cyan
      input = gets.strip

      # Allows a user to continue to select items from the list
      while input.start_with?(/\d/)

      # Ensures the chosen number is within the range of the display array
        unless (1..results.length).to_a.include?(input.to_i)
          puts "\tPlease choose a number from the list.".red
          input = gets.strip
          next
        end

        puts "\n\t#{results[input.to_i - 1].name}".blue
        puts "\n\t#{Scraper.get_item_info(results[input.to_i - 1])}".blue
        puts "\tEnter your next search or 'exit'.".cyan
        input = gets.strip
      end
    end
  end

end
