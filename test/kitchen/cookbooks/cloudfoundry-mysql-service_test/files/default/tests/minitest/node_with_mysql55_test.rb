require File.expand_path('../support/helpers', __FILE__)

require 'sqlite3'

describe 'cloudfoundry-mysql-service::node' do
  include Helpers::CFServiceMySQLTest

  before do
    # Give the service some time to start up.
    sleep 10
  end

  it 'creates a instances dir' do
    directory('/var/vcap/services/mysql/instances').must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates a database' do
    file('/var/vcap/services/mysql/mysql_node.db').must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates a valid config file' do
    file("/etc/cloudfoundry/mysql_node.yml").must_exist.with(:owner, 'cloudfoundry')
    YAML.load_file('/etc/cloudfoundry/mysql_node.yml')
  end

  it 'creates a config file with the expected content' do
    config = YAML.load_file('/etc/cloudfoundry/mysql_node.yml')
    {
      "capacity" => 200,
      "plan" => "free",
      "local_db" => "sqlite3:/var/vcap/services/mysql/mysql_node.db",
      "mbus" => "nats://nats:nats@localhost:4222/",
      "index" => 0,
      "base_dir" => "/var/vcap/services/mysql/instances",
      "mongod_log_dir" => "/var/log/cloudfoundry/mysql",
      "pid" => "/var/run/cloudfoundry/mysql_node.pid",
      "node_id" => "mysql_node_0",
      "op_time_limit" => 6,
      "supported_versions" => ["5.5"],
      "default_version" => "5.5",
      "mysql_path" => {
        "5.5" => "/usr/bin/mysqld"
      },
      "mysqlestore_path" => {
        "5.5" => "/usr/bin/mysqldump"
      },
      "myssql_options" => {
        "5.5" => ""
      },
      "port_range" => {
        "first" => 25001,
        "last" => 45000
      },
      "migration_nfs" => "/mnt/migration",
      "logging" => {
        "level" => "info",
        "file" => "/var/log/cloudfoundry/mysql_node.log"
      }
    }.each do |k,v|
      config[k].must_equal v
    end
  end

  it 'has no provisioned services' do
    db = sqlite('/var/vcap/services/mysql/mysql_node.db')
    rows = db.execute("select * from vcap_services_mongo_db_node_provisioned_services")
    rows.must_equal []
  end

protected
  def sqlite(path)
    @sqlite ||= SQLite3::Database.new(path)
  end
end
