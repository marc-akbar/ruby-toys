######################################################

# Web scraping test with mountianproject
# Scrapes popular routes from each major location

######################################################

require 'nokogiri'
require 'open-uri'

def collect_areas

  # start on mountianproject.com home page
  html = "https://www.mountainproject.com/"
  doc = Nokogiri::HTML(open(html))
  guide = doc.css('#route-guide div.mb-half')
  areas = guide.css('strong a')
  output = {}

  # find the name and link to each state's page
  areas.each do |area|
    output[area.text] = area['href']
  end

  # send results to next method
  collect_popular_routes(output)
end

def collect_popular_routes(area_hash)

  puts "Collecting popular routes from:"
  output = []

  # for each state, find the popular route table
  area_hash.each do |area, url|
    puts "  #{area}"
    area = area
    html = url
    doc = Nokogiri::HTML(open(html))

    # find the link to more climbs in state
    more_climb_link = doc.css("div.main-content a:contains('More Classic')").first

    # if the link doesn'e exist move to the next state
    more_climb_link ? more_climb_link = more_climb_link['href'] : next
    route_doc = Nokogiri::HTML(open(more_climb_link))

    # find hidden table with popular routes (easier to work with)
    table = route_doc.css('div.table-responsive table.hidden-sm-up')
    name, location, grade, routes = [], [], [], []

    # grab name, location and grade from each route in table parsing empty strings
    table.search('tr').each do |tr|
      name << tr.css('td a strong').text
      location << tr.css('td div.text-warm a').first.text
      # if route is mixed/ice/snow grab the grade from another div that contains other elements
      grade << (tr.css('td a span.rateYDS').text != "" ? tr.css('td a span.rateYDS').text : tr.css('td a div.float-xs-right').text.split("\n")[1].strip)
    end

    # combine route info to export
    name.length.times do |i|
      routes << "#{name[i]} (#{grade[i]}) - #{location[i]}"
    end

    # add state name above route info table
    routes.unshift(area.upcase, "")
    output << routes
  end

  puts "Collection complete"
  output
end
