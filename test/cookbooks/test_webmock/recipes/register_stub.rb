include_recipe 'test_webmock::_register_stubs'

remote_file '/tmp/index.html' do
  source 'http://example.com/index.html'
end

data = third_party_http_request "google.com", '/foo/bar'
file '/tmp/data.txt' do
  content data
end
