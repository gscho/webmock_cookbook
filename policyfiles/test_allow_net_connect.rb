name 'test_allow_net_connect'

run_list 'test_webmock::allow_net_connect'

cookbook 'test_webmock', path: '../test/cookbooks/test_webmock'
cookbook 'webmock', path: '../'
