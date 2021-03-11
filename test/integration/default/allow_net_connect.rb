describe file('/tmp/allow.txt') do
  it { should exist }
  its('content') { should eq '<h1>Allowed</h1>' }
end

