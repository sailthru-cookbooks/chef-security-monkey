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

git "/opt/security_monkey" do
  repository 'https://github.com/Netflix/security_monkey.git'
  revision 'master'
  action :sync
  notifies :run, "bash[install_security_monkey]"
end

include_recipe "python::default"

python_pip "setuptools"

bash "install_security_monkey" do
 # environment {"SECURITY_MONKEY_SETTINGS" => "/opt/security_monkey/env-config/config-deploy.py"}
  user "root"
  cwd "/opt/security_monkey"
  code <<-EOF
  python setup.py install
  python manage.py db upgrade
  EOF
  action :nothing
end

#upgrade datatables

#deploy config template
template "/opt/security_monkey/env-config/config-deploy.py" do
  mode "0644"
  source "env-config/config-deploy.py.erb"
end