service_name = "mysqld"

service "#{service_name}" do
  provider Chef::Provider::Service::Systemd
  supports :restart => true, :stop => true, :start => true, :status => true
  action :restart
end
