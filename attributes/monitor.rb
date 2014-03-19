# Have ossec watch the log
node.default[:ossec][:watched][:mon_notification] = {
  '/var/log/mon-notification/notification.log' => :syslog
}
