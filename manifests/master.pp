class puppet::master (
  $bindaddress    = $puppet::master::params::bindaddress,
  $autosign       = $puppet::master::params::autosign,
  $external_nodes = $puppet::master::params::external_nodes,
  $node_terminus  = $puppet::master::params::node_terminus,
  $modulepath     = $puppet::master::params::modulepath,
  $factpath       = $puppet::master::params::factpath,
  $templatedir    = $puppet::master::params::templatedir,
  $reports        = $puppet::master::params::reports,
  $reporturl      = $puppet::master::params::reporturl,
  $webserver      = $puppet::master::params::webserver) inherits puppet::master::params {
  include puppet

  package { 'puppetmaster':
    ensure  => $puppet::ensure,
    require => Apt::Source['puppetlabs']
  }

  Ini_setting {
    path    => "${puppet::confdir}/puppet.conf",
    section => 'master',
    ensure  => $puppet::ensure,
  }

  ini_setting { 'bindaddress':
    setting => 'bindaddress',
    value   => $bindaddress,
  }

  ini_setting { 'autosign':
    setting => 'autosign',
    value   => $autosign,
  }

  ini_setting { 'modulepath':
    setting => 'modulepath',
    value   => $modulepath,
  }

  ini_setting { 'factpath':
    setting => 'factpath',
    value   => $factpath,
  }

  ini_setting { 'templatedir':
    setting => 'templatedir',
    value   => $templatedir,
  }

  if ($external_nodes != '') {
    ini_setting { 'external_nodes':
      setting => 'external_nodes',
      value   => $external_nodes,
    }

    ini_setting { 'node_terminus':
      setting => 'node_terminus',
      value   => $node_terminus,
    }
  }

  if ($reports != '') {
    ini_setting { 'reports':
      setting => 'reports',
      value   => $reports,
    }

    if ('http' in $reports and $reporturl != '') {
      ini_setting { 'reporturl':
        setting => 'reporturl',
        value   => $reporturl,
      }
    }
  }

  class { "puppet::master::webserver::${webserver}":
    require => Package['puppetmaster'],
  }
}
