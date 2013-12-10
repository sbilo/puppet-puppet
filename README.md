sbilo-puppet
=============

This module installs/configures puppet from the puppetlabs-apt repositories. Can be used for master, agent and dashboard installation.

Dependencies (optional):

    'sbilo/unicorn', '>=0.1.0'
    'sbilo/nginx', '>=0.1.0'

Configure an agent
------------------
Basic configuration of a puppet agent on a host:

	class { 'puppet::agent':
		server 		=> 'puppetmaster-01.example.com',
		runinterval => 30,
		report		=> true,
	}

Configure a puppetmaster
------------------------
Basic configuration using Webrick as webserver (non-production).

	class { 'puppet::master':
		autosign => true,
	}

Using Unicorn with Nginx as webserver. This requires both the 'sbilo/unicorn' and 'sbilo/nginx' modules.

	class { 'puppet::master':
		webserver => 'unicorn',
	}