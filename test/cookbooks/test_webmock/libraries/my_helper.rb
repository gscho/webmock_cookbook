require 'net/http'
require 'uri'

module MyHelper
  def third_party_http_request(url, path)
    http = Net::HTTP.new(url, 80)
    response = http.request(Net::HTTP::Get.new(path))
    response.body
  end
end

Chef::Recipe.send(:include, MyHelper)
