class Card < ActiveRecord::Base
  attr_accessor :deck_url
  attr_reader :team_urls, :doc

  def initialize(deck_url)
    @deck_url = deck_url
    @doc = Nokogiri::HTML(open(deck_url))
    get_card_data
  end
  
  # def scrape_team_urls
  #   @team_urls ||= doc.search("div.team-qualifiedteams a").collect{|a| normalize_team_url(a["href"])}.uniq.compact
  # end

  # def scrape_teams
  #   team_urls.collect{|url| Team.new(url)}
  # end

  def get_card_data
    puts another_page?
  end

  def another_page?
    puts "Got to another_page?"
    get_links.each do |link|
      puts "In the logic branch"
      if check_link_text(link)
        true
        break
      else
        false
      end
    end
  end

  def get_links
    @doc.css("a")
  end

  def check_link_text(link)
    link.text.include?(">")
  end

  
  private
    # def normalize_team_url(url)
    #   url.start_with?("http://") ? url : "http://www.fifa.com#{url}"
    # end



end
