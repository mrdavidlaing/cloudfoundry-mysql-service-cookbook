include_recipe "cloudfoundry::user"
include_recipe "nats::server"

node.set['postgresql']['password']['postgres'] = 'test-password'
node.set['cloudfoundry_cloud_controller']['server']['api_uri'] = 'http://10.0.2.15:9022/'

include_recipe "postgresql::server"
include_recipe "cloudfoundry-cloud_controller::database"
include_recipe "cloudfoundry-cloud_controller::server"

%w[sqlite3 libsqlite3-ruby libsqlite3-dev].each do |p|
  package(p).run_action(:install)
end
chef_gem "sqlite3"  # only for tests
