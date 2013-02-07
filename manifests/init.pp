class resolvconf {
  Augeas {
    context => '/files/etc/resolv.conf',
    load_path => "$settings::vardir/augeas/lenses",
  }
}
