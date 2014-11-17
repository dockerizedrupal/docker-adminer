class adminer::httpd {
  require adminer::packages
  require adminer::httpd::supervisor

  file { '/etc/apache2/sites-enabled/000-default':
    ensure => absent
  }

  file { '/etc/apache2/sites-available/default':
    ensure => present,
    content => 'puppet:///modules/adminer/etc/apache2/sites-available/default',
    mode => 644
  }

  file { '/etc/apache2/sites-enabled/default':
    ensure => link,
    target => '/etc/apache2/sites-available/default',
    require => File['/etc/apache2/sites-available/default']
  }

  file { '/etc/apache2/sites-available/default-ssl':
    ensure => present,
    content => 'puppet:///modules/adminer/etc/apache2/sites-available/default-ssl',
    mode => 644
  }

  file { '/etc/apache2/sites-enabled/default-ssl':
    ensure => link,
    target => '/etc/apache2/sites-available/default-ssl',
    require => File['/etc/apache2/sites-available/default-ssl']
  }
}