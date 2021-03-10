resource_name :webmock

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

  def disable_net_connect!
    WebMock.disable_net_connect!
  end

  def allow_net_connect!
    WebMock.allow_net_connect!
  end

  def stub(block)
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

action :allow_net_connect do
  enable!
  allow_net_connect!
end

action :disable_net_connect do
  enable!
  disable_net_connect!
end

action :stub do
  enable!

  stub(new_resource.block)
end
