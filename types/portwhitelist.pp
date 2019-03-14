# matches valid port_whitelist option(s)
# accepts either space seperated list of
# 1) a 'protocol:port' pair
# OR a single entry of:
# 2) an asterisk ('*')
# Only the UDP or TCP protocol may be specified,
# and the port number must be between 1 and 65535 inclusive
type Rkhunter::PortWhitelist = Pattern['^(?x)(?:(?:(?:TCP)|(?:UDP)):(?:
[1-9][0-9]{0,3}|
[1-5][0-9]{4}|
6[0-4][0-9]{3}|
65[0-4][0-9]{2}|
655[0-2][0-9]|
6553[0-5])
(?:\s(?:(?:TCP)|(?:UDP)):(?:
[1-9][0-9]{0,3}|
[1-5][0-9]{4}|
6[0-4][0-9]{3}|
65[0-4][0-9]{2}|
655[0-2][0-9]|
6553[0-5]))*
)$']
