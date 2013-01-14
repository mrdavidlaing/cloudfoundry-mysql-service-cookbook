#
# Cookbook Name:: cloudfoundry-mysql-service
# Recipe:: gateway
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

service_rbenv do
  namespace 'cloudfoundry_mysql_service'
  component 'gateway'
end

include_recipe "cloudfoundry_service::dependencies"
#gem: mysql2 (0.3.10) required by cloudfoundry_service_component[mysql_gateway] needs the mysql-dev libraries to compile
%w[libmysql-ruby libmysqlclient-dev].each do |p|
  package p
end

cloudfoundry_service_component "mysql_gateway" do
  service_name  "mysql"
  ruby_version  node['cloudfoundry_mysql_service']['gateway']['ruby_version']
  action        [:create, :enable]
end
