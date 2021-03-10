webmock 'stub example.com' do
  block do
    stub_request(:get, "http://example.com/index.html").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host'=>'example.com',
        'User-Agent'=>'Chef Infra Client Knife/16.9.20 (ruby-2.7.2-p137; ohai-16.8.2; x86_64-linux; +https://chef.io)',
        'X-Chef-Version'=>'16.9.20'
        }).
      to_return(status: 200, body: "<h1>Hello World!</h1>", headers: {})
  end
  action :stub
end

remote_file '/tmp/index.html' do
  source 'http://example.com/index.html'
end
