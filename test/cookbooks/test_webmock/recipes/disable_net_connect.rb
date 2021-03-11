case node['platform']
when 'debian', 'ubuntu'
  apache = 'apache2'
when 'redhat', 'centos'
  apache = 'httpd'
end

package apache

file '/var/www/html/index.html' do
  content '<h1>Allowed</h1>'
end

service apache do
  action %i(start enable)
end

webmock 'disable but allow localhost' do
  action :disable_net_connect
  allow_localhost true
end

remote_file '/tmp/allow_localhost.txt' do
  source 'http://localhost/index.html'
end

webmock 'disable but allow bar' do
  action :disable_net_connect
  allowed_hosts ['example.com']
end

remote_file '/tmp/allowed_hosts.txt' do
  source 'http://example.com/index.html'
end
