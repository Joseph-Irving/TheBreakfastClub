class graphite (
  $gr_group                               = '',
  $gr_user                                = '',
  $gr_enable_carbon_cache                 = true,
  $gr_max_cache_size                      = inf,
  $gr_max_updates_per_second              = 500,
  $gr_max_updates_per_second_on_shutdown  = undef,
  $gr_max_creates_per_minute              = 50,
  $gr_carbon_metric_prefix                = 'carbon',
  $gr_carbon_metric_interval              = 60,
  $gr_line_receiver_interface             = '0.0.0.0',
  $gr_line_receiver_port                  = 2003,
  $gr_enable_udp_listener                 = 'False',
  $gr_udp_receiver_interface              = '0.0.0.0',
  $gr_udp_receiver_port                   = 2003,
  $gr_pickle_receiver_interface           = '0.0.0.0',
  $gr_pickle_receiver_port                = 2004,
  $gr_log_listener_connections            = 'True',
  $gr_use_insecure_unpickler              = 'False',
  $gr_use_whitelist                       = 'False',
  $gr_whitelist                           = [ '.*' ],
  $gr_blacklist                           = [ ],
  $gr_cache_query_interface               = '0.0.0.0',
  $gr_cache_query_port                    = 7002,
  $gr_cache_write_strategy                = 'sorted',
  $gr_timezone                            = 'GMT',
  $gr_storage_schemas                     = [
    {
      name       => 'carbon',
      pattern    => '^carbon\.',
      retentions => '1m:90d'
    },
    {
      name       => 'default',
      pattern    => '.*',
      retentions => '1s:30m,1m:1d,5m:2y'
    }
  ],
  $gr_storage_aggregation_rules           = {
    '00_min' => {
      pattern => '\.min$',
      factor => '0.1',
      method => 'min'
    },
    '01_max' => {
      pattern => '\.max$',
      factor => '0.1',
      method => 'max'
    },
    '02_sum' => {
      pattern => '\.count$',
      factor => '0.1',
      method => 'sum'
    },
    '99_default_avg' => {
      pattern => '.*',
      factor => '0.5',
      method => 'average'
    }
  },
  $gr_web_server                          = 'apache',
  $gr_web_servername                      = $::fqdn,
  $gr_web_group                           = $graphite::params::web_group,
  $gr_web_user                            = $graphite::params::web_user,
  $gr_web_cors_allow_from_all             = false,
  $gr_use_ssl                             = false,
  $gr_ssl_cert                            = undef,
  $gr_ssl_key                             = undef,
  $gr_ssl_dir                             = undef,
  $gr_apache_port                         = 80,
  $gr_apache_port_https                   = 443,
  $gr_apache_conf_template                = 'graphite/etc/apache2/sites-available/graphite.conf.erb',
  $gr_apache_conf_prefix                  = '',
  $gr_apache_24                           = $::graphite::params::apache_24,
  $gr_apache_noproxy                      = undef,
  $gr_django_1_4_or_less                  = false,
  $gr_django_db_engine                    = 'django.db.backends.sqlite3',
  $gr_django_db_name                      = '/opt/graphite/storage/graphite.db',
  $gr_django_db_user                      = '',
  $gr_django_db_password                  = '',
  $gr_django_db_host                      = '',
  $gr_django_db_port                      = '',
  $gr_enable_carbon_relay                 = false,
  $gr_relay_line_interface                = '0.0.0.0',
  $gr_relay_line_port                     = 2013,
  $gr_relay_pickle_interface              = '0.0.0.0',
  $gr_relay_pickle_port                   = 2014,
  $gr_relay_log_listener_connections      = 'True',
  $gr_relay_method                        = 'rules',
  $gr_relay_replication_factor            = 1,
  $gr_relay_destinations                  = [ '127.0.0.1:2004' ],
  $gr_relay_max_queue_size                = 10000,
  $gr_relay_use_flow_control              = 'True',
  $gr_relay_rules                         = {
    all => {
      pattern      => '.*',
      destinations => [ '127.0.0.1:2004' ]
    },
    'default' => {
      'default'    => true,
      destinations => [ '127.0.0.1:2004:a' ]
    },
  },
  $gr_enable_carbon_aggregator            = false,
  $gr_aggregator_line_interface           = '0.0.0.0',
  $gr_aggregator_line_port                = 2023,
  $gr_aggregator_enable_udp_listener      = 'False',
  $gr_aggregator_udp_receiver_interface   = '0.0.0.0',
  $gr_aggregator_udp_receiver_port        = 2023,
  $gr_aggregator_pickle_interface         = '0.0.0.0',
  $gr_aggregator_pickle_port              = 2024,
  $gr_aggregator_log_listener_connections = 'True',
  $gr_aggregator_forward_all              = 'True',
  $gr_aggregator_destinations             = [ '127.0.0.1:2004' ],
  $gr_aggregator_replication_factor       = 1,
  $gr_aggregator_max_queue_size           = 10000,
  $gr_aggregator_use_flow_control         = 'True',
  $gr_aggregator_max_intervals            = 5,
  $gr_aggregator_rules                    = {
    'carbon-all-mem'   => 'carbon.all.memUsage (60) = sum carbon.*.*.memUsage',
    'carbon-class-mem' => 'carbon.all.<class>.memUsage (60) = sum carbon.<class>.*.memUsage',
    },
  $gr_amqp_enable                         = 'False',
  $gr_amqp_verbose                        = 'False',
  $gr_amqp_host                           = 'localhost',
  $gr_amqp_port                           = 5672,
  $gr_amqp_vhost                          = '/',
  $gr_amqp_user                           = 'guest',
  $gr_amqp_password                       = 'guest',
  $gr_amqp_exchange                       = 'graphite',
  $gr_amqp_metric_name_in_body            = 'False',
  $gr_memcache_hosts                      = undef,
  $secret_key                             = 'UNSAFE_DEFAULT',
  $gr_cluster_servers                     = undef,
  $gr_carbonlink_hosts                    = undef,
  $gr_cluster_fetch_timeout               = 6,
  $gr_cluster_find_timeout                = 2.5,
  $gr_cluster_retry_delay                 = 60,
  $gr_cluster_cache_duration              = 300,
  $nginx_htpasswd                         = undef,
  $nginx_proxy_read_timeout               = 10,
  $manage_ca_certificate                  = true,
  $gr_use_ldap                            = false,
  $gr_ldap_uri                            = '',
  $gr_ldap_search_base                    = '',
  $gr_ldap_base_user                      = '',
  $gr_ldap_base_pass                      = '',
  $gr_ldap_user_query                     = '(username=%s)',
  $gr_ldap_options                        = {},
  $gr_use_remote_user_auth                = 'False',
  $gr_remote_user_header_name             = undef,
  $gr_local_data_dir                      = '/opt/graphite/storage/whisper',
  $gunicorn_arg_timeout                   = 30,
  $gunicorn_bind                          = 'unix:/var/run/graphite.sock',
  $gunicorn_workers                       = 2,
  $gr_cache_instances                     = [],
  $gr_relay_instances                     = [],
  $gr_aggregator_instances                = [],
  $gr_whisper_autoflush                   = 'False',
  $gr_whisper_lock_writes                 = 'False',
  $gr_whisper_fallocate_create            = 'False',
  $gr_log_cache_performance               = 'False',
  $gr_log_rendering_performance           = 'False',
  $gr_log_metric_access                   = 'False',
  $wsgi_processes                         =  5,
  $wsgi_threads                           =  5,
  $wsgi_inactivity_timeout                =  120,
  $gr_django_tagging_pkg                  = $::graphite::params::django_tagging_pkg,
  $gr_django_tagging_ver                  = $::graphite::params::django_tagging_ver,
  $gr_twisted_pkg                         = $::graphite::params::twisted_pkg,
  $gr_twisted_ver                         = $::graphite::params::twisted_ver,
  $gr_txamqp_pkg                          = $::graphite::params::txamqp_pkg,
  $gr_txamqp_ver                          = $::graphite::params::txamqp_ver,
  $gr_graphite_pkg                        = $::graphite::params::graphite_pkg,
  $gr_graphite_ver                        = $::graphite::params::graphite_ver,
  $gr_carbon_pkg                          = $::graphite::params::carbon_pkg,
  $gr_carbon_ver                          = $::graphite::params::carbon_ver,
  $gr_whisper_pkg                         = $::graphite::params::whisper_pkg,
  $gr_whisper_ver                         = $::graphite::params::whisper_ver,
  $gr_django_pkg                          = $::graphite::params::django_pkg,
  $gr_django_ver                          = $::graphite::params::django_ver,
  $gr_django_provider                     = $::graphite::params::django_provider,
  $gr_pip_install                         = true,
  $gr_disable_webapp_cache                = false,
  $gr_carbonlink_query_bulk               = undef,
  $gr_carbonlink_hosts_timeout            = '1.0',
  $gr_rendering_hosts                     = undef,
  $gr_rendering_hosts_timeout             = '1.0',
  $gr_prefetch_cache                      = undef
) inherits graphite::params {

  validate_string($gr_use_remote_user_auth)

  # validate bools
  validate_bool($gr_enable_carbon_cache)
  validate_bool($gr_web_cors_allow_from_all)
  validate_bool($gr_use_ssl)
  validate_bool($gr_django_1_4_or_less)
  validate_bool($gr_enable_carbon_relay)
  validate_bool($gr_enable_carbon_aggregator)
  validate_bool($manage_ca_certificate)
  validate_bool($gr_use_ldap)
  validate_bool($gr_pip_install)
  validate_bool($gr_disable_webapp_cache)

  # validate integers
  validate_integer($gr_apache_port)
  validate_integer($gr_apache_port_https)

  Anchor['graphite::begin']->
  Class['graphite::install']~>
  Class['graphite::config']->
  Anchor['graphite::end']

  anchor { 'graphite::begin':}
  include graphite::install
  include graphite::config
  anchor { 'graphite::end':}
}
