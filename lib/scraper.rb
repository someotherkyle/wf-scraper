require_relative 'item.rb'
module Scraper
  BaseURL = 'https://warframe.fandom.com'

  def self.compile_list
    # A fixed number of items are listed so this array will allow us to complete our item scrape
    url_list = ['/wiki/Category:Components',
                '/wiki/Category:Components?from=K',
                '/wiki/Category:components?from=T']

    item_list = []

    url_list.each do |url|
      doc = Nokogiri::HTML(open(BaseURL + url))
      doc.css("a.category-page__member-link").each do |link|
        name = link.attribute('title').text
        href = link.attribute('href').value
        item = Item.new(name, href)
        item_list << item unless item_list.include?(item)
      end
    end
    item_list
  end

  def self.get_item_info(item)
      doc = Nokogiri::HTML(open(BaseURL + item.href))
      doc.css("#mw-content-text p").text
  end

end

Scraper.compile_list
