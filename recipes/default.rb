# preferable for the OS to install then easy_install to try and compile the MySQL-python package
package 'python-mysqldb' do
  action :install
end

easy_install_package 'mon-notification' do
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

# todo - setup an encrypted data bag for credentials
hosts = data_bag_item(node[:mon_notification][:data_bag], 'hosts')
template "#{node[:mon_notification][:conf_dir]}/notification.yaml" do
  action :create
  source 'notification.yaml.erb'
  owner 'root'
  group node[:mon_notification][:group]
  mode 0640
  variables(
    :hosts => hosts
  )
  notifies :restart, "service[mon-notification]"
end
