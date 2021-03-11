webmock 'stub example.com' do
  block do
    stub_request(:get, "http://example.com/index.html").
     with(
       headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Host'=>'example.com',
      'User-Agent'=>'Chef Infra Client Knife/16.10.17 (ruby-2.7.2-p137; ohai-16.10.6; x86_64-linux; +https://chef.io)',
      'X-Chef-Version'=>'16.10.17'
       }).
      to_return(status: 200, body: "<h1>Hello World!</h1>", headers: {})
  end
  action :run
end

webmock 'stub google.com' do
  block do
    stub_request(:get, "http://google.com/foo/bar").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: "It worked!", headers: {})
  end
  action :run
end.run_action(:run)
