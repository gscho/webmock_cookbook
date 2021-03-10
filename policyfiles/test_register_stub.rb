name 'test_register_stub'

run_list 'test_webmock::register_stub'

cookbook 'test_webmock', path: '../test/cookbooks/test_webmock'
cookbook 'webmock', path: '../'
