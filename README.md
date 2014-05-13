mon_notification Cookbook
=========================
Sets up the mon-notification daemon

Requirements
------------
The cookbook only requires access to the mon-notification package.

Attributes
----------
#### mon_notification::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:mon_notification][:user]</tt></td>
    <td>String</td>
    <td>System user for the daemon</td>
    <td><tt>mon-notification</tt></td>
  </tr>
  <tr>
    <td><tt>[:mon_notification][:group]</tt></td>
    <td>String</td>
    <td>System group for the daemon</td>
    <td><tt>mon-notification</tt></td>
  </tr>
  <tr>
    <td><tt>[:mon_notification][:conf_dir]</tt></td>
    <td>String</td>
    <td>Configuration Directory</td>
    <td><tt>/etc/mon</tt></td>
  </tr>
  <tr>
    <td><tt>[:mon_notification][:data_bag]</tt></td>
    <td>String</td>
    <td>Configuration data bag</td>
    <td><tt>mon_notification</tt></td>
  </tr>
  <tr>
    <td><tt>[:mon_notification][:log_dir]</tt></td>
    <td>String</td>
    <td>Daemon log directory</td>
    <td><tt>/var/log/mon-notification</tt></td>
  </tr>
</table>

Data Bags
---------
A simple data bag item named hosts in node[:mon_notification][:data_bag] is required for running. It simply has 4 dictionary items
for the host names to connect to. The names and services are, kafka, mysql, smtp and zookeeper

Usage
-----
Simply include the mon_notification default recipe in a role.
