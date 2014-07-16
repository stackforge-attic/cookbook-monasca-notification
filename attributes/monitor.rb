# encoding: UTF-8
# Have ossec watch the log
node.default[:ossec][:watched][:monasca_notification] = {
  '/var/log/monasca/notification.log' => :syslog
}
