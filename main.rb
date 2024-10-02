require './EasyBrokerService'

broker = EasyBrokerService.new()
total_pages = broker.getTotalPagesFor("properties", 50)

for i in 1..total_pages do
  content = broker.properties(i, 50)
  puts "Page: " + i.to_s
  content["content"].each do |property|
    if property.has_key?("title")
      index = "[" + property["public_id"] + "] "
      puts index + "Title: " + property["title"].to_s
    else
      puts "Record doesn't have a title property."
    end

    break unless content["pagination"].has_key?("next_page")
  end
end