package 'mon-notification' do
  action :upgrade
end

user node[:mon_notification][:group] do
  action :create
end
user node[:mon_notification][:user] do
  action :create
  system true
  gid node[:mon_notification][:group]
end

template '/etc/init/mon-notification.conf' do
  action :create
  source 'mon-notification.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end

service 'mon-notification' do
  action :enable
  provider Chef::Provider::Service::Upstart
end

directory node[:mon_notification][:conf_dir] do
  action :create
  owner 'root'
  group 'root'
  mode 0755
end

directory node[:mon_notification][:log_dir] do
  action :create
  owner node[:mon_notification][:user]
  group node[:mon_notification][:group]
  mode 0775
end

# todo - setup a data bag for the config details and an encrypted one for credentials
template "#{node[:mon_notification][:conf_dir]}/notification.yaml" do
  action :create
  source 'notification.yaml.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[mon-notification]"
end
