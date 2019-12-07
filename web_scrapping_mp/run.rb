require File.join(File.dirname(__FILE__), '/mountain_project_routes.rb')

# create file with resulting data
file = File.new('popular_routes.txt', 'w')
file.puts "Popular Climbs by State (source: mountainproject.com)"
2.times{ file.puts }
if File.exist?(file) && File.writable?(file)
  collect_areas.each do |row|
    file.puts row
    file.puts
    file.puts "------------------------------------------------"
    file.puts
  end
end

puts "Writing complete"
