require 'httparty'

class EasyBrokerService
  include HTTParty
  base_uri 'https://api.stagingeb.com/v1'

  # Initializes a new class instance
  def initialize()
    @headers = {
        "accept" => "application/json",
        "X-Authorization" => "l7u502p8v46ba3ppgvj5y2aad50lb9"
    }
  end

  # Fetches a list of properties from the EasyBroker API.
  #
  # @param page [Integer] The page number to retrieve (optional, default: 1).
  # @param limit [Integer] The number of properties to retrieve per page (optional, default: 20).
  # @return [Hash] A Hash object containing the list of properties and pagination information.
  # @raise [StandardError] If an error occurs during the API call.
  def properties(page = 1, limit = 20)
    begin
      self.class.get("/properties?page=" + page.to_s + "&limit=" + limit.to_s, {
        headers: @headers
      })
    rescue StandardError => e
      puts "Error fetching properties: " + e.message
    end
  end

  # Calculates the total number of pages for the given list.
  #
  # @param list [String] The list to get the pages from
  # @param limit [Integer] The number of properties to retrieve per page (optional, default: 20).
  # @return [Integer] The total number of pages.
  def getTotalPagesFor(list, limit = 20)
    if (limit > 50)
      puts "getTotalPagesFor error => Maximum limit is 50"
    end
    if list == "properties"
      response = self.properties(1, 50)
    end
    total = response["pagination"]["total"]
    limit = response["pagination"]["limit"]
    return (total.to_f / limit.to_f).ceil
  end
end