#
# Cookbook Name:: security-monkey
# Recipe:: default
#
# Copyright (C) 2014 David F. Severski
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe "python::default"
python_pip "setuptools"

user "#{node['security_monkey']['user']}" do
  home "#{node['security_monkey']['homedir']}"
  system true
  action :create
  manage_home true
end

group "#{node['security_monkey']['group']}" do
  #gid #{node['security_monkey']['user']}
  members #{node['security_monkey']['user']}
  append true
  system true
end

directory node['security_monkey']['basedir'] do
  owner "#{node['security_monkey']['user']}"
  group "#{node['security_monkey']['group']}"
  mode 00755
  action :create
end

git "#{node['security_monkey']['basedir']}" do
  repository 'https://github.com/Netflix/security_monkey.git'
  revision 'master'
  user "#{node['security_monkey']['user']}"
  group "#{node['security_monkey']['group']}"
  action :sync
  notifies :run, "bash[install_security_monkey]", :immediately
end

bash "install_security_monkey" do
  #environment "SECURITY_MONKEY_SETTINGS" => "#{node['security_monkey']['basedir']}/env-config/config-deploy.py"
  user "root"
  cwd "#{node['security_monkey']['basedir']}"
  code <<-EOF
  python setup.py install
  EOF
  action :nothing
end

#deploy config template
template "#{node['security_monkey']['basedir']}/env-config/config-deploy.py" do
  mode "0644"
  source "env-config/config-deploy.py.erb"
  notifies :run, "bash[create_database]", :immediately
end

#upgrade datatables
bash "create_database" do
  user "root"
  cwd "#{node['security_monkey']['basedir']}"
  code <<-EOF
  sudo -u postgres createdb secmonkey
  python manage.py db upgrade
  EOF
  environment "SECURITY_MONKEY_SETTINGS" => "#{node['security_monkey']['basedir']}/env-config/config-deploy.py"
  not_if "psql -lqt | cut -d \| -f 1 | grep -w secmonkey", :user => 'posstgres'
  action :nothing
end

package "supervisor"

template "#{node['security_monkey']['basedir']}/supervisor/security_monkey.ini" do
  mode "0644"
  source "supervisor/security_monkey.ini.erb"
  notifies :run, "bash[install_supervisor]"
end

bash "install_supervisor" do
  user "root"
  cwd "#{node['security_monkey']['basedir']}/supervisor"
  code <<-EOF
  sudo -E supervisord -c security_monkey.ini
  sudo -E supervisorctl -c security_monkey.ini
  EOF
  environment 'SECURITY_MONKEY_SETTINGS' => "#{node['security_monkey']['basedir']}/env-config/config-deploy.py"
  action :nothing
end