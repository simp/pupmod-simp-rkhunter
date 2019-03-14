require 'spec_helper.rb'

default_content  = <<EOM
ALLOW_SSH_PROT_V1=0
ALLOW_SSH_ROOT_USER=no
ALLOW_SYSLOG_REMOTE_LOGGING=0
APPEND_LOG=0
AUTO_X_DETECT=0
COLOR_SET2=0
COPY_LOG_ON_ERROR=0
DBDIR=/var/lib/rkhunter/db
DISABLE_TESTS=suspscan hidden_ports hidden_procs deleted_files packet_cap_apps apps
ENABLE_TESTS=ALL
GLOBSTAR=0
HASH_CMD=SHA256
HASH_FLD_IDX=1
IMMUTABLE_SET=0
INSTALLDIR=/usr
IPC_SEG_SIZE=1048576
LANGUAGE=en
LOCK_TIMEOUT=300
LOCKDIR=/var/run/lock
LOGFILE=/var/log/rkhunter/rkhunter.log
MIRRORS_MODE=0
PHALANX2_DIRTEST=0
PKGMGR=RPM
ROTATE_MIRRORS=1
SCAN_MODE_DEV=THOROUGH
SCRIPTDIR=/usr/share/rkhunter/scripts
SHOW_LOCK_MSGS=1
SHOW_SUMMARY_TIME=3
SHOW_SUMMARY_WARNINGS_NUMBER=0
SKIP_INODE_CHECK=0
SSH_CONFIG_DIR=/etc/ssh
SUSPSCAN_MAXSIZE=1024000
SUSPSCAN_TEMP=/dev/shm
SUSPSCAN_THRESH=200
TMPDIR=/var/lib/rkhunter
UNHIDE_TESTS=sys
UNHIDETCP_OPTS=
UPDATE_MIRRORS=1
UPDT_ON_OS_CHANGE=0
USE_LOCKING=1
USE_SUNSUM=0
USE_SYSLOG=LOCAL6.NOTICE
WARN_ON_OS_CHANGE=1
WHITELISTED_IS_WHITE=0
EOM

default_content_with_all_optionals  = <<EOM
ALLOWDEVFILE=/some/path
ALLOWHIDDENDIR=/some/path
ALLOWHIDDENFILE=/some/path
ALLOWIPCPID=852
ALLOWIPCPROC=/some/path
ALLOWIPCUSER=/some/path
ALLOWPROCDELFILE=/some/path
ALLOWPROCLISTEN=/some/path
ALLOWPROMISCIF=/some/path
ALLOW_SSH_PROT_V1=0
ALLOW_SSH_ROOT_USER=no
ALLOW_SYSLOG_REMOTE_LOGGING=0
APPEND_LOG=0
APP_WHITELIST=/some/path
ATTRWHITELIST=/some/path
AUTO_X_DETECT=0
BINDIR=/some/path
COLOR_SET2=0
COPY_LOG_ON_ERROR=0
DBDIR=/var/lib/rkhunter/db
DISABLE_TESTS=suspscan hidden_ports hidden_procs deleted_files packet_cap_apps apps
EMPTY_LOGFILES=/some/path
ENABLE_TESTS=ALL
EPOCH_DATE_CMD=/some/path
EXCLUDE_USER_FILEPROP_FILES_DIRS=/some/path
EXISTWHITELIST=/some/path
GLOBSTAR=0
HASH_CMD=SHA256
HASH_FLD_IDX=1
IGNORE_PRELINK_DEP_ERR=/some/path
IMMUTABLE_SET=0
IMMUTWHITELIST=/some/path
INETD_ALLOWED_SVC=/some/path
INETD_CONF_PATH=/some/path
INSTALLDIR=/usr
IPC_SEG_SIZE=1048576
LANGUAGE=en
LOCK_TIMEOUT=300
LOCKDIR=/var/run/lock
LOGFILE=/var/log/rkhunter/rkhunter.log
MAIL-ON-WARNING=blah blah
MAIL_CMD=mail -s "[rkhunter] Warnings found for ${HOST_NAME}"
MIRRORS_MODE=0
MISSING_LOGFILES=/some/path
MODULES_DIR=/some/path
OS_VERSION_FILE=/etc/redhat-release
PASSWORD_FILE=/some/path
PHALANX2_DIRTEST=0
PKGMGR_NO_VRFY=/some/path
PKGMGR=RPM
PORT_PATH_WHITELIST=/some/path
PORT_WHITELIST=TCP:51
PWDLESS_ACCOUNTS=/some/path
READLINK_CMD=/bin/ls
ROTATE_MIRRORS=1
RTKT_DIR_WHITELIST=/some/path
RTKT_FILE_WHITELIST=/some/path
SCAN_MODE_DEV=THOROUGH
SCANROOTKITMODE=THOROUGH
SCRIPTDIR=/usr/share/rkhunter/scripts
SCRIPTWHITELIST=/some/path
SHARED_LIB_WHITELIST=/some/path
SHOW_LOCK_MSGS=1
SHOW_SUMMARY_TIME=3
SHOW_SUMMARY_WARNINGS_NUMBER=0
SKIP_INODE_CHECK=0
SSH_CONFIG_DIR=/etc/ssh
STARTUP_PATHS=/dev/
STAT_CMD=/bin/ls
SUSPSCAN_DIRS=/some/path
SUSPSCAN_MAXSIZE=1024000
SUSPSCAN_TEMP=/dev/shm
SUSPSCAN_THRESH=200
SUSPSCAN_WHITELIST=/some/path
SYSLOG_CONFIG_FILE=/some/path
TMPDIR=/var/lib/rkhunter
UID0_ACCOUNTS=/some/path
UNHIDE_TESTS=sys
UNHIDETCP_OPTS=
UPDATE_LANG=/some/path
UPDATE_MIRRORS=1
UPDT_ON_OS_CHANGE=0
USE_LOCKING=1
USER_FILEPROP_FILES_DIRS=/some/path
USE_SUNSUM=0
USE_SYSLOG=LOCAL6.NOTICE
WARN_ON_OS_CHANGE=1
WEB_CMD=curl
WHITELISTED_IS_WHITE=0
WRITEWHITELIST=/some/path
XINETD_ALLOWED_SVC=/some/path
XINETD_CONF_PATH=/some/path
EOM

shared_examples_for 'a rkhunter::config' do |content|
  it { is_expected.to compile.with_all_deps }
  it { is_expected.to create_class('rkhunter') }
  it { is_expected.to contain_class('rkhunter::config') }
  it { is_expected.to contain_file('/etc/rkhunter.conf').with({
      :ensure       => 'file',
      :owner        => 'root',
      :group        => 'root',
      :mode         => '0640',
      :content      => content,
      :require      => 'Package[rkhunter]',
      :validate_cmd => 'rkhunter -C --configfile %'
      } )
  }
end

describe 'rkhunter' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        context 'with default parameters used by rkhunter::config' do
          it_should_behave_like 'a rkhunter::config', default_content
        end
        context 'with default parameters and all optionals set' do
          let(:hieradata) { "config" }
          it_should_behave_like 'a rkhunter::config', default_content_with_all_optionals
        end
      end
    end
  end
end
