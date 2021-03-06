action :wait_until_cluster_ready do

  bash new_resource.name do
    user node['ndb']['user']
    code <<-EOF
      #{node['mysql']['base_dir']}/bin/ndb_waiter -c #{node['ndb']['connectstring']} --timeout=#{node['ndb']['wait_startup']}  --nowait-nodes=#{new_resource.nowait_nodes}  2>&1 > /dev/null
    EOF
  end
  new_resource.updated_by_last_action(true)
end

# 

action :backup_config do

  bash "backup_config_ini" do
    user node['ndb']['user']
    code <<-EOF
    DATE_WITH_TIME=$(date "+%Y%m%d-%H%M%S")
    mkdir -p #{node['ndb']['root_dir']}/.backup_configs
    cp #{node['ndb']['root_dir']}/config.ini #{node['ndb']['root_dir']}/.backup_configs/config.ini_${DATE_WITH_TIME}
  EOF
  end

end  
