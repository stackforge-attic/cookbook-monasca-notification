# encoding: UTF-8
#
include_recipe 'python'

# preferable for the OS to install this then to have pip compile
%w[ python-mysqldb libmysqlclient-dev ].each do |pkg_name|
  package pkg_name do
    action :install
  end
end

python_pip 'monasca-notification' do
  action :upgrade
end

group node[:monasca_notification][:group] do
  action :create
end
user node[:monasca_notification][:user] do
  action :create
  system true
  gid node[:monasca_notification][:group]
end

template '/etc/init/monasca-notification.conf' do
  action :create
  source 'monasca-notification.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end

service 'monasca-notification' do
  action :enable
  provider Chef::Provider::Service::Upstart
end

directory node[:monasca_notification][:conf_dir] do
  action :create
  owner 'root'
  group 'root'
  mode 0755
end

directory node[:monasca_notification][:log_dir] do
  action :create
  owner node[:monasca_notification][:user]
  group node[:monasca_notification][:group]
  mode 0775
end

# TODO: setup an encrypted data bag for credentials
hosts = data_bag_item(node[:monasca_notification][:data_bag], 'hosts')
template "#{node[:monasca_notification][:conf_dir]}/notification.yaml" do
  action :create
  source 'notification.yaml.erb'
  owner 'root'
  group node[:monasca_notification][:group]
  mode 0640
  variables(
    hosts: hosts
  )
  notifies :restart, 'service[monasca-notification]'
end
