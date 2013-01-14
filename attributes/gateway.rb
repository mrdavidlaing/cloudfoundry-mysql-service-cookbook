#
# Cookbook Name:: cloudfoundry-mysql-service
# Attributes:: gateway
#
# Copyright 2013, ZephirWorks
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

# Log level for the service gateway daemon.
default['cloudfoundry_mysql_service']['gateway']['log_level'] = "info"

# Time out for talking to a service node.
default['cloudfoundry_mysql_service']['gateway']['node_timeout'] = 30

# Time out for completing (de)provisioning requests.
default['cloudfoundry_mysql_service']['gateway']['timeout'] = 15

# Human-readable aliases for MySQL versions.
default['cloudfoundry_mysql_service']['gateway']['version_aliases'] = {
  'previous' => '5.5',
  'current' => '5.5',
  'next' => '5.5'
}
