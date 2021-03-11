name 'test_disable_net_connect'

run_list 'test_webmock::disable_net_connect'

cookbook 'test_webmock', path: '../test/cookbooks/test_webmock'
cookbook 'webmock', path: '../'
