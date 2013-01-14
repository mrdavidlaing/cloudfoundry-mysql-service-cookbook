name             "cloudfoundry-mysql-service"
maintainer       "Andrea Campi"
maintainer_email "andrea.campi@zephirworks.com"
license          "Apache 2.0"
description      "Installs/Configures cloudfoundry-mysql-service"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.3"

%w( ubuntu ).each do |os|
  supports os
end

%w( cloudfoundry mysql ).each do |cb|
  depends cb
end
depends "cloudfoundry_service", "~> 1.2.0"
