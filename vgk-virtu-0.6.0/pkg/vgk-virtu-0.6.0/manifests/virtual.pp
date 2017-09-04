define virtu::virtual ($uid,$realname,$pass,$userfiles = false) {

  exec { "change_initial_password":
    path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    onlyif  => "grep ${title} /etc/shadow | grep -Eq \':[*!]!?:\'",
    command => "usermod -p \'${pass}\' ${title}",
    require => User["${title}"],
  }


  user { $title:
    ensure           => 'present',
    uid              => $uid,
    gid              => $title,
    groups           => ['wheel'],
    shell            => '/bin/bash',
    membership       => minimum,
    password_max_age => '90',
    password_min_age => '7',
    home             => "/home/${title}",
    comment          => $realname,
    managehome       => true,
    require          => Group["${title}"],
  }


  group { $title:
    ensure => 'present',
    gid    => $uid,
  }

  # userfiles
  if $userfiles == false {
    # just create the directory
    file { "/home/${title}":
    ensure  => 'directory',
    mode    => '0755',
    owner   => $title,
    group   => $title,
    require => User["${title}"],
    }
  } else {
    # copy in all the files in the subdirectory
    file { "/home/${title}":
    ensure  => 'directory',
    recurse => true,
    mode    => '0755',
    owner   => $title,
    group   => $title,
    source  => "puppet:///modules/virtu/users/${title}",
    require => User["${title}"],
    }
  }
}
