describe file('/tmp/index.html') do
  it { should exist }
  its('content') { should eq '<h1>Hello World!</h1>' }
end
