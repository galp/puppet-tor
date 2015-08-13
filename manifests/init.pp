class tor (
  $gateway               = false,
  $hidden_service        = true,
  $hidden_service_dir    = 'default',
  $hidden_service_ports  = 'default',
  $basename              = 'lol',
  $ip                    = $::ipaddress_lo,
  )
{

  $packagelist = ['tor','tor-geoipdb']
  package { $packagelist :
    ensure  => latest,
    require => Apt::Source['tor_apt_repo']
  }

  apt::source { 'tor_apt_repo':
    location => 'http://deb.torproject.org/torproject.org',
    repos    => 'main',
    key      => 'A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89',
  }

  file { '/etc/tor/torrc':
    ensure  => present,
    content => template("${module_name}/torrc.erb"),
    require => Package[$packagelist],
    notify  => Service['tor'],
  }
  if $hidden_service {
    
    file { "/var/lib/tor/${hidden_service_dirs}" :
      ensure  => directory,
      owner   => debian-tor,
      group   => debian-tor,
      notify  => Service['tor'],
      require => Package['tor'],
    }
  }
  service { 'tor' :
    ensure  => running,
    enable  => true,
    require => File['/etc/tor/torrc'],
  }
}
