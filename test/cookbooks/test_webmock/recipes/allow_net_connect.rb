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

webmock 'allow' do
  action :allow_net_connect
end

remote_file '/tmp/allow.txt' do
  source 'http://localhost/index.html'
end
