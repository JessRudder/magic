class CardScraper
  attr_accessor :deck_url, :card_info
  attr_reader :doc

  def initialize(deck_url)
    @deck_url = deck_url
    @doc = Nokogiri::HTML(open(deck_url))
    get_card_data
  end

  def get_card_data
    another_page?
    make_card_array
    make_cards
  end

  def another_page?
    more_pages = false
    get_links.each do |link|
      more_pages = true if check_link_text(link)
    end
    more_pages
  end

  def get_links
    @doc.css("a")
  end

  def check_link_text(link)
    link.text.include?(">")
  end

  def make_card_array
    @card_info = @doc.css(".cardItem")
  end

  def make_cards
    @card_info.each do |current_card|
      this_card = {:title => find_title(current_card), :mana_cost => find_mana_cost(current_card), 
        :converted_mana_cost => find_converted_mana_cost(current_card), :card_type => find_card_type(current_card), :rules => find_rules(current_card),
        :set => find_set(current_card), :color => find_color(current_card), :image_link => find_card_image_link(current_card)}
      Card.create(this_card)
    end
  end

  def find_title(current_card)
    current_card.css('.cardTitle').css('a').text
  end  

  def find_mana_cost(current_card)
    #gets the img els that have the mana cost - need to iterate through to pull just the text
    current_card.css(".manaCost").css("img")
    "this is a place holder"
  end

  def find_converted_mana_cost(current_card)
    current_card.css(".convertedManaCost").text.to_i
  end

  def find_card_type(current_card)
    #need to normalize this data somehow
    current_card.css(".typeLine").text.strip
  end

  def find_rules(current_card)
    current_card.css(".rulesText").text.strip
  end

  def find_set(current_card)
    #may be possible to simplify, also will need to remove (common), (rare), etc
    current_card.css(".rightCol img").first.attributes["title"].value
  end

  def find_color(current_card)
    #this info is not currently available
    ""
  end

  def find_card_image_link(current_card)
    make_full_url(current_card.css(".leftCol a img").first.attributes["src"].value)
  end

  private

  def make_full_url(partial_url)
    partial_url.gsub("../../", "http://gatherer.wizards.com/")
  end

end
