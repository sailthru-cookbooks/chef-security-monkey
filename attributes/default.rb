default['security_monkey']['basedir'] = '/opt/secmonkey'

default['security_monkey']['secret_key'] = '2e8062fa-0ebe-11e4-a372-000c293fc5c4'
default['security_monkey']['password_salt']       = '1406ac54-0ebe-11e4-8f54-000c293fc5c4'

default['security_monkey']['postgres']

default['security_monkey']['mail_sender'] = 'securitymonkey@example.tld'
default['security_monkey']['security_team_email'] = 'securityteam@example.tld'

# account attributes
default['security_monkey']['user'] = 'secmonkey'
default['security_monkey']['group'] = 'secmonkey'
default['security_monkey']['user_opts'] = { homedir: '/home/secmonkey', uid: nil, gid: nil }
default['security_monkey']['create_account'] = true
default['security_monkey']['join_groups'] = []
default['security_monkey']['homedir'] = '/home/secmonkey'