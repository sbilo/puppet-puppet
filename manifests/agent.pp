class puppet::agent (
  $server      = $puppet::agent::params::server,
  $runinterval = $puppet::agent::params::runinterval,
  $report      = $puppet::agent::params::report) inherits puppet::agent::params {
  include puppet

  Ini_setting {
    path    => "${puppet::confdir}/puppet.conf",
    section => 'agent',
    ensure  => $puppet::ensure,
  }

  ini_setting { 'server':
    setting => 'server',
    value   => $server,
  }

  ini_setting { 'runinterval':
    setting => 'runinterval',
    value   => $runinterval,
  }

  ini_setting { 'report':
    setting => 'report',
    value   => $report,
  }

  file { '/etc/default/puppet':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'START=yes
DAEMON_OPTS=""',
    require => Package['puppet']
  }

  service { 'puppet':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    provider  => 'upstart',
  }
}