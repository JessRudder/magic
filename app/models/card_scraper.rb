class CardScraper
  attr_accessor :deck_url, :card_info, :base_url, :deck_list
  attr_reader :doc

  @@deck_url = ""
  @@base_url = "http://gatherer.wizards.com/Pages/Search/Default.aspx?set="
  @@deck_list = ["Alara%20Reborn"]
  # @@deck_list = ["Alara%20Reborn", "Alliances", "Antiquities", "Apocalypse", 
  #   "Arabian%20Nights", "Archenemy", "Avacyn%20Restored", "Battle%20Royale%20Box%20Set", 
  #   "Beatdown%20Box%20Set", "Betrayers%20of%20Kamigawa", "Born%20of%20the%20Gods", 
  #   "Champions%20of%20Kamigawa", "Chronicles", "Classic%20Sixth%20Edition", "Coldsnap", 
  #   "Commander%202013%20Edition", "Commander%202014", "Commander%27s%20Arsenal", "Conflux", 
  #   "Dark%20Ascension", "Darksteel", "Dissension", "Dragon%27s%20Maze", 
  #   "Duel%20Decks:%20Ajani%20vs.%20Nicol%20Bolas", 
  #   "Duel%20Decks:%20Divine%20vs.%20Demonic", "Duel%20Decks:%20Elspeth%20vs.%20Tezzeret", 
  #   "Duel%20Decks:%20Elves%20vs.%20Goblins", "Duel%20Decks:%20Garruk%20vs.%20Liliana", 
  #   "Duel%20Decks:%20Heroes%20vs.%20Monsters", "Duel%20Decks:%20Izzet%20vs.%20Golgari", 
  #   "Duel%20Decks:%20Jace%20vs.%20Chandra", "Duel%20Decks:%20Jace%20vs.%20Vraska", 
  #   "Duel%20Decks:%20Knights%20vs.%20Dragons", 
  #   "Duel%20Decks:%20Phyrexia%20vs.%20the%20Coalition", 
  #   "Duel%20Decks:%20Sorin%20vs.%20Tibalt", "Duel%20Decks:%20Speed%20vs.%20Cunning", 
  #   "Duel%20Decks:%20Venser%20vs.%20Koth", "Eight%20Edition", "Eventide", "Exodus", 
  #   "Fallen%20Empires", "Fifth%20Dawn", "Fifth%20Edition", "Fourth%20Edition", 
  #   "From%20the%20Vault:%20Annihilation%20(2014)", "From%20the%20Vault:%20Dragons", 
  #   "From%20the%20Vault:%20Exiled", "From%20the%20Vault:%20Legends", 
  #   "From%20the%20Vault:%20Realms", "From%20the%20Vault:%20Relics", 
  #   "From%20the%20Vault:%20Twenty", "Future%20Sight", "Gatecrash", "Guildpact", "Homelands", 
  #   "Ice%20Age", "Innistrad", "Invasion", "Journey%20into%20Nyx", "Judgment", "Khans%20of%20Tarkir", 
  #   "Legends", "Legions", "Limited%20Edition%20Alpha", "Limited%20Edition%20Beta", "Lorwyn", 
  #   "Magic%202010", "Magic%202011", "Magic%202012", "Magic%202013", "Magic%202014%20Core%20Set", 
  #   "Magic%202015%20Core%20Set", "Magic:%20The%20Gathering-Commander", 
  #   "Magic:%20The%20Gathering-Conspiracy", "Masters%20Edition", "Masters%20Edition%20II", 
  #   "Masters%20Edition%20III", "Masters%20Edition%20IV", "Mercadian%20Masques", "Mirage", "Mirrodin", 
  #   "Mirrodin%20Besieged", "Modern%20Event%20Deck%202014", "Modern%20Masters", "Morningtide", 
  #   "Nemesis", "New%20Phyrexia", "Ninth%20Edition", "Odyssey", "Onslaught", "Planar%20Chaos", 
  #   "Planechase", "Planechase%202012%20Edition", "Planeshift", "Portal", "Portal%20Second%20Age", 
  #   "Portal%20Three%20Kingdoms", "Promo%20set%20for%20Gatherer", "Prophecy", 
  #   "Premium%20Deck%20Series:%20Fire%20and%20Lightning", 
  #   "Premium%20Deck%20Series:%20Graveborn", "Premium%20Deck%20Series:%20Slivers", 
  #   "Ravnica:%20City%20of%20Guilds", "Return%20to%20Ravnica", "Revised%20Edition", "Rise%20of%20the%20Eldrazi", 
  #   "Saviors%20of%20Kamigawa", "Scars%20of%20Mirrodin", "Scourge", "Seventh%20Edition", "Shadowmoor", 
  #   "Shards%20of%20Alara", "Starter%201999", "Starter%202000", "Stronghold", "Tempest", 
  #   "Tenth%20Edition", "The%20Dark", "Theros", "Time%20Spiral", "Torment", "Unglued", "Unhinged", 
  #   "Unlimited%20Edition", "Vanguard", "Vintage%20Masters", "Visions", "Weatherlight", 
  #   "Worldwake", "Zendikar", "Urza%27s%20Destiny", "Urza%27s%20Legacy", "Urza%27s%20Saga"]
  
    # Couldn't get it to work for "Time%20Spiral%20\"Timeshifted\""

  def initialize
    start_url_iteration
  end

  def start_url_iteration
    @@deck_list.each do |deck|
      @doc = Nokogiri::HTML(open("#{@@base_url}[#{deck}]"))
      get_card_data
    end
  end

  def get_card_data
    keep_scraping = true
    while keep_scraping
      if another_page?
        make_card_array
        make_cards
        @@deck_url
        @doc = Nokogiri::HTML(open(@@deck_url))
      else
        make_card_array
        make_cards
        keep_scraping = false
      end
    end
  end

  def another_page?
    more_pages = false
    get_links.each do |link|
      if check_link_text(link)
        more_pages = true
        @@deck_url = make_full_page_url(link.attributes["href"].value)
        break
      end
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
        :set => find_set_and_rarity(current_card)[0], :rarity => find_set_and_rarity(current_card)[1], :color => find_color(current_card), 
        :image_link => find_card_image_link(current_card)}
      Card.create(this_card)
    end
  end

  def find_title(current_card)
    current_card.css('.cardTitle').css('a').text
  end  

  def find_mana_cost(current_card)
    #gets the img els that have the mana cost - need to iterate through to pull just the text
    mana_list = current_card.css(".manaCost").css("img")
    mana = ""
    mana_list.each do |el|
     mana += "#{el.attributes["alt"].value}, "
    end
    mana.slice(0,mana.length - 2)
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

  def find_set_and_rarity(current_card)
    #may be possible to simplify, also will need to remove (common), (rare), etc
    full_set = current_card.css(".rightCol img").first.attributes["title"].value
    set = full_set.slice(0,full_set.index(" ("))
    rarity = full_set.slice(full_set.index("(")+1,full_set.length).gsub(")","")
    [set,rarity]
  end

  def find_color(current_card)
    #this info is not currently available
    ""
  end

  def find_card_image_link(current_card)
    make_full_card_url(current_card.css(".leftCol a img").first.attributes["src"].value)
  end

  private

  def make_full_card_url(partial_url)
    partial_url.gsub("../../", "http://gatherer.wizards.com/")
  end

  def make_full_page_url(partial_url)
    partial_url.prepend("http://gatherer.wizards.com")
  end

end
