resource_name :webmock
property :allow_net_connect, [true, false], default: false
property :allow_localhost, [true, false], default: false
property :allowed_hosts, Array

def block(&block)
  set_or_return(:block, block, {})
end

action_class do

  def enable!
    load_gem 'rexml', 'rexml/rexml'
    load_gem 'webmock'
    self.class.include WebMock::API

    WebMock.enable!
  end

  def disable_net_connect!(allow_localhost, allowed_hosts)
    if allowed_hosts.nil? || allowed_hosts.empty?
      WebMock.disable_net_connect!(allow_localhost: allow_localhost)
    else
      WebMock.disable_net_connect!(allow_localhost: allow_localhost, allow: /#{allowed_hosts.join('|')}/)
    end
  end

  def allow_net_connect!
    WebMock.allow_net_connect!
  end

  def run(block)
    instance_eval(&block)
  end

  def load_gem(name, require_path = name)
    gem name
    require name
  rescue LoadError
    Chef::Log.info("Gem #{name} not installed. Installing now")
    chef_gem name do
      compile_time true
    end

    require require_path
  end

end

action :run do
  enable!
  if new_resource.allow_net_connect
    allow_net_connect!
  else
    disable_net_connect!(new_resource.allow_localhost, new_resource.allowed_hosts)
  end

  run(new_resource.block) unless new_resource.block.nil?
end

action :allow_net_connect do
  enable!

  allow_net_connect!
end

action :disable_net_connect do
  enable!

  disable_net_connect!(new_resource.allow_localhost, new_resource.allowed_hosts)
end
