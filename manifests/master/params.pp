class puppet::master::params {
  $bindaddress = '*'
  $autosign = true
  $external_nodes = undef
  $node_terminus = 'exec'
  $modulepath = '$confdir/modules'
  $factpath = '$vardir/lib/facter'
  $templatedir = '$confdir/templates'
  $reports = undef
  $reporturl = undef
  $webserver = 'webrick'
}
