class puppet::dashboard (
  $environment = $puppet::dashboard::params::environment,
  $database    = $puppet::dashboard::params::database,
  $username    = $puppet::dashboard::params::username,
  $password    = $puppet::dashboard::params::password,
  $host        = $puppet::dashboard::params::host,) inherits puppet::dashboard::params {
  package { 'puppet-dashboard': ensure => installed, }

  file { '/etc/puppet-dashboard/database.yml':
    content => template('puppet/dashboard/database.yml.erb'),
    require => Package['puppet-dashboard'],
    owner   => 'root',
    group   => 'www-data',
    mode    => '0660',
  }

  exec { 'rake RAILS_ENV=production db:migrate':
    command     => "rake RAILS_ENV=${environment} db:migrate",
    cwd         => '/usr/share/puppet-dashboard',
    require     => File['/etc/puppet-dashboard/database.yml'],
    subscribe   => File['/etc/puppet-dashboard/database.yml'],
    refreshonly => true,
  }
}
