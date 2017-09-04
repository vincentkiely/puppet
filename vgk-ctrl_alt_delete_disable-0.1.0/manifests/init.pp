# == Class: ctrl_alt_delete_disable
# This module disables CTRL-ALT-DELETE reboot action; we need to do this in case
# the Windows guys accidentally reboot one of our servers from the console.
# For RHEL6 ensure /etc/init/control-alt-delete.conf is an empty file to disable CTRL-ALT-DEL
# For RHEL7 ensure /etc/systemd/system/ctrl-alt-del.target is a link to /dev/null to disable CTRL-ALT-DEL

class ctrl_alt_delete_disable {

case $::operatingsystemmajrelease {
  default: {
    fail('OS not supported')
  }
  7: {
  file { '/etc/systemd/system/ctrl-alt-del.target':
    ensure   => 'link',
    group    => '0',
    mode     => '0777',
    owner    => '0',
    selrange => 's0',
    selrole  => 'object_r',
    seltype  => 'systemd_unit_file_t',
    seluser  => 'unconfined_u',
    target   => '/dev/null',
    }
    }
  6: {
  file { '/etc/init/control-alt-delete.conf':
    ensure   => 'file',
    content  => '',
    group    => '0',
    mode     => '0644',
    owner    => '0',
    selrange => 's0',
    selrole  => 'object_r',
    seltype  => 'etc_t',
    seluser  => 'system_u',
}
}
}
}
