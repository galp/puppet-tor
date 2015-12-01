class tor::apt {
  apt::source { 'tor_apt_repo':
    location => 'http://deb.torproject.org/torproject.org',
    repos    => 'main',
    key      => 'A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89',
  }
}
