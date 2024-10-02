require 'httparty'
require './EasyBrokerService'

RSpec.describe EasyBrokerService do
  let(:broker) { EasyBrokerService.new }

  # Test the `properties` method
  describe "#properties" do
    it "returns a list of properties" do
      response = broker.properties(1, 20)
      expect(response.parsed_response).to be_a(Hash)
      expect(response["content"]).to be_an(Array)
      expect(response["content"].first).to have_key("public_id")
    end
  end

  # Test the `getTotalPagesForProperties` method
  describe "#getTotalPagesForProperties" do
    it "returns the correct total pages" do
      total_pages = broker.getTotalPagesFor("properties", 50)
      expect(total_pages).to eq(23)
    end
  end
end