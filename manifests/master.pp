class puppet::master (
    $bindaddress              = $puppet::master::params::bindaddress,
    $ssl_client_header        = $puppet::master::params::ssl_client_header,
    $ssl_client_verify_header = $puppet::master::params::ssl_client_verify_header,
    $autosign                 = $puppet::master::params::autosign,
    $external_nodes           = $puppet::master::params::external_nodes,
    $node_terminus            = $puppet::master::params::node_terminus,) inherits puppet::master::params {
    include puppet

    package { 'puppetmaster': ensure => $puppet::ensure, }

    Ini_setting {
        path    => "${puppet::confdir}/puppet.conf",
        section => 'master',
        ensure  => $puppet::ensure,
    }

    ini_setting { 'bindaddress':
        setting => 'bindaddress',
        value   => $bindaddress,
    }

    ini_setting { 'ssl_client_header':
        setting => 'ssl_client_header',
        value   => $ssl_client_header,
    }

    ini_setting { 'ssl_client_verify_header':
        setting => 'ssl_client_verify_header',
        value   => $ssl_client_verify_header,
    }

    ini_setting { 'autosign':
        setting => 'autosign',
        value   => $autosign,
    }

    if (defined($external_nodes)) {
        ini_setting { 'external_nodes':
            setting => 'external_nodes',
            value   => $external_nodes,
        }

        ini_setting { 'node_terminus':
            setting => 'node_terminus',
            value   => $node_terminus,
        }
    }
}
