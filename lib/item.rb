class Item

  attr_reader :name, :href, :description

  def initialize(name, href)
    @name = name
    @href = href
  end

  def add_description(description)
    @description = description
  end

end

