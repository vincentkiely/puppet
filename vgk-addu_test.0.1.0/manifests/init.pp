# == Class: addu_test
#
# Full description of class addu_test here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'addu_test':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
#class addu_test {
#Create tst uset and set onetime password

  $test_passwd = '$6$RSijbB8W1TcHZNFD$SHErPMOZ90kiS5hRWckHu8Wg7P./T.Wfe4Sq.E5FldFSAg6FFEBTcwhnK/mmL2EhtaF6.0vgjxHAcGUrqDEAT0'

  exec {"test_passwd_set":
    path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    onlyif  => 'grep -q \'test:!!:\' /etc/shadow',
    command => "usermod -p \'$test_passwd\' test",
    require => User['test'],
  }

  user { 'test':
    ensure           => 'present',
    comment          => 'Test User',
    gid              => '1000',
    groups           => ['test','wheel'],
    membership	     => minimum,
    home             => '/home/test',
    password_max_age => '90',
    password_min_age => '7',
    shell            => '/bin/bash',
    uid              => '1000',
    managehome       => true,
    require          => Group['test'],
  }

  group { 'test':
  ensure => 'present',
  gid    => '1000',
  }
#}
