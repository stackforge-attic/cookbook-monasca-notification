include_recipe "python"

# preferable for the OS to install this then to have pip compile
%[python-mysqldb libmysqlclient-dev].each do |pkg_name|
  package pkg_name do
    action :install
  end
end

python_pip 'mon-notification' do
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
