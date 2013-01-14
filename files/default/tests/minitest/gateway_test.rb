require File.expand_path('../support/helpers', __FILE__)

begin
  require 'pg'
rescue LoadError
  Chef::Log.warn "Can not load gem 'pg', trying to continue anyway"
end

describe 'cloudfoundry-mysql-service::gateway' do
  include Helpers::CFServiceMySQL

  before do
    # Give the service some time to register with the cloud_controller;
    # plus sometimes the cloud_controller is really slow to start.
    sleep 90
  end

  it 'registers a service in the cloud_controller DB' do
    db = connect('cloud_controller', 'cloudfoundry', 'cloudfoundry')
    res = db.query("select * from services")
    res.count.must_equal 1

    row = res[0]
    row['provider'].must_be_nil
    row['token'].wont_be_nil
    row['binding_options'].must_be_nil
    row['acls'].must_be_nil
    row['active'].must_equal   "t"
    row['url'].must_match      %r{^http://10\.0\.2\.15:\d+$}

    row['label'].must_equal    "mysql-5.5"
    row['name'].must_equal     "mysql"
    row['version'].must_equal  "5.5"
    row['timeout'].must_equal  "15"

    tags = YAML.load(row['tags'])
    tags.must_equal ["mysql", "mysql-5.5"]

    plans = YAML.load(row['plans'])
    plans.must_equal ["free"]
    row['plan_options'].must_be_nil
    row['default_plan'].must_equal "free"

    versions = YAML.load(row['supported_versions'])
    versions.must_equal []
    aliases = YAML.load(row['version_aliases'])
    aliases.must_equal({"previous"=>"5.5", "current"=>"5.5", "next"=>"5.5"})
  end

protected
  def connect(dbname, user, password)
    @db ||= ::PGconn.new(
      :host => '127.0.0.1',
      :port => 5432,
      :dbname => dbname,
      :user => user,
      :password => password
    )
  end
end
