class CardScraper

  attr_accessor :deck_url
  attr_reader :doc

  def initialize(deck_url)
    @deck_url = deck_url
    @doc = Nokogiri::HTML(open(deck_url))
    get_card_data
  end

  def get_card_data
    another_page?
    puts another_page?
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

  def make_cards
  end
  
end
