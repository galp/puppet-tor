class tor (
  $gateway               = $tor::params::gateway,
  $hidden_service        = $tor::params::hidden_service,
  $tor_relay             = $tor::params::tor_relay,
  $relay_contact_info    = $tor::params::relay_contact_info,
  $nickname              = $tor::params::nickname,
  $orport                = $tor::params::orport,
  $bandwidth_rate        = $tor::params::bandwidth_rate,
  $bandwidth_burst       = $tor::params::bandwidth_burst,
  $hidden_service_dir    = $tor::params::hidden_service_dir,
  $hidden_service_ports  = $tor::params::hidden_service_ports,
  $basename              = $tor::params::basename,
  $ip                    = $tor::params::ip,
  ) inherits tor::params
{
  contain tor::apt
  $packagelist = ['tor','tor-geoipdb']
  package { $packagelist :
    ensure  => latest,
    require => Class['tor::apt']
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
