# webmock cookbook

This cookbook will enable the `webmock` resource in any cookbooks that depend on it.

## What can you do with this cookbook?

This cookbook is a simple wrapper around the [webmock](https://github.com/bblimke/webmock) gem. This gem allows you to mock any HTTP request and return a value for test purposes. Doing so allows you to decouple external HTTP services from testing the logic of your cookbook.

Use cases:

- testing a chef library helper that makes HTTP requests to an external service
- mocking responses from services that are not accessible locally

This cookbooks just gives you convenient access to the `webmock` gem. All `webmock` APIs are documented here: https://github.com/bblimke/webmock

## How to use

This resource is meant for testing. That means you should only call these resources when testing a cookbook! If you're already using test kitchen, you could include this recipe when running test-kitchen tests or using an attribute.

```
# A webmock resource enables mocking of http requests from within a recipe

webmock 'registering a stub' do
  block               block
  allow_net_connect   true, false
  allow_localhost     true, false
  allowed_hosts       []
end

where:

- block is a block of ruby code to execute with the webmock api
- allow_net_connect is a boolean to allow outbound http requests
- allow_localhost disables outbound http requests except localhost
- allowed_hosts disables all outbound http requests except these hosts


```

### Mocking for a chef resource

```
# Everything inside the block is using the webmock documentation
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

# This will be mocked
remote_file '/tmp/index.html' do
  source 'http://example.com/index.html'
end
```

### Mocking for a chef library

**The order is important! You must also make sure run_action(:run) is specified to make sure the resouce executes at compile time**

```
# Everything inside the block is using the webmock documentation
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

# This will be mocked
data = third_party_http_request "google.com", '/foo/bar'
file '/tmp/data.txt' do
  content data
end

```
