include_recipe "cloudfoundry-mysql-service::install55"
include_recipe "cloudfoundry-mysql-service_test::node"

node.default['cloudfoundry_mysql_service']['node']['default_version'] = "5.5"

include_recipe "cloudfoundry-mysql-service::node"
