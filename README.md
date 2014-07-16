monasca_notification Cookbook
=========================
Sets up the monasca-notification daemon

Requirements
------------
The cookbook only requires access to the monasca-notification package.

Attributes
----------
#### monasca_notification::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:monasca_notification][:user]</tt></td>
    <td>String</td>
    <td>System user for the daemon</td>
    <td><tt>monasca-notification</tt></td>
  </tr>
  <tr>
    <td><tt>[:monasca_notification][:group]</tt></td>
    <td>String</td>
    <td>System group for the daemon</td>
    <td><tt>monasca-notification</tt></td>
  </tr>
  <tr>
    <td><tt>[:monasca_notification][:conf_dir]</tt></td>
    <td>String</td>
    <td>Configuration Directory</td>
    <td><tt>/etc/monasca</tt></td>
  </tr>
  <tr>
    <td><tt>[:monasca_notification][:data_bag]</tt></td>
    <td>String</td>
    <td>Configuration data bag</td>
    <td><tt>monasca_notification</tt></td>
  </tr>
  <tr>
    <td><tt>[:monasca_notification][:log_dir]</tt></td>
    <td>String</td>
    <td>Daemon log directory</td>
    <td><tt>/var/log/monasca-notification</tt></td>
  </tr>
</table>

Data Bags
---------
A data bag item named hosts in node[:monasca_notification][:data_bag] is required for running. It simply has 4 dictionary items
for the host names and auth infomation to connect to the services: kafka, mysql, smtp and zookeeper

Usage
-----
Simply include the monasca_notification default recipe in a role.
