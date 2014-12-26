class adminer {
  if ! file_exists('/adminer/ssl/certs/adminer.crt') {
    require adminer::httpd::ssl
  }

  if $mysqld_host {
    file { '/adminer/data/index.php':
      ensure  => present,
      content => template('adminer/index.php.erb')
    }
  }
}
