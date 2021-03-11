describe file('/tmp/allow_localhost.txt') do
  it { should exist }
end

describe file('/tmp/allowed_hosts.txt') do
  it { should exist }
end
