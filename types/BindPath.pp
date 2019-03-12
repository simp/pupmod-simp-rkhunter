# matches valid binddir path
# accepts absolute path or an absolute path
# with a '+' proceeding it
type Rkhunter::BindPath = Pattern['^(?:\/|\+\/)(?:[^\/\0]+\/*)*$']
