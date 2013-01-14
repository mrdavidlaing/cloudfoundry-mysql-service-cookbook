#
# Cookbook Name:: cloudfoundry-mysql-service
# Recipe:: install55
#
# Copyright 2013, David Laing
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.set['cloudfoundry_mysql_service']['node']['versions']['5.5'] = {}
mysql55cfg = node['cloudfoundry_mysql_service']['node']['versions']['5.5']
mysql55cfg['mysql_base_path'] = "/usr"
mysql55cfg['mysql_options'] = ""

#TODO - Do other services get there passwords from some global password store?
cloudfoundry_service_password = "cloudfoundry"
node.set['mysql']['server_debian_password'] = cloudfoundry_service_password
node.set['mysql']['server_root_password'] = cloudfoundry_service_password
node.set['mysql']['server_repl_password'] = cloudfoundry_service_password

include_recipe "mysql::server"

service "mysql" do
  action [:stop, :disable]
  only_if { ::File.exists?("/etc/init.d/mysql") }
end

file "/etc/init.d/mysql" do
  action :delete
end
