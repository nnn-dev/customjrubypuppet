require 'pp'
require 'puppet'

Puppet.settings.initialize_app_defaults({:logdir=>'/dev/null',:confdir=>'/dev/null',:vardir=>'/dev/null',:codedir=>'/dev/null',:rundir=>'/dev/null'})
Puppet[:code] = "notify{a:}"
env = Puppet::Node::Environment.create("production",[])
environments = Puppet::Environments::Static.new(env)
Puppet.push_context({:environments=>environments, :current_environment=>env},"setup")
node=Puppet::Node.new('test',{:environment=>env})
pp Puppet::Parser::Compiler.compile(node)
