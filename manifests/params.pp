class tor::params {
  $gateway               = false
  $hidden_service        = true
  $tor_relay             = false
  $relay_contact_info    = '0xFFFFFFFF Random Person <nobody AT example dot com>'
  $nickname              = 'sillynickname'
  $orport                = '9001'
  $bandwidth_rate        = '100'
  $bandwidth_burst       = '200'
  $hidden_service_dir    = 'default'
  $hidden_service_ports  = 'default'
  $basename              = 'lol'
  $ip                    = $::ipaddress_lo
}
