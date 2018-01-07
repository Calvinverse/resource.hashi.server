# frozen_string_literal: true

#
#


#
# FIREWALL
#

# Allow communication on the loopback address (127.0.0.1 and ::1)
default['firewall']['allow_loopback'] = true

# Do not allow MOSH connections
default['firewall']['allow_mosh'] = false

# Do not allow WinRM (which wouldn't work on Linux anyway, but close the ports just to be sure)
default['firewall']['allow_winrm'] = false

# No communication via IPv6 at all
default['firewall']['ipv6_enabled'] = false

#
# NOMAD
#

default['nomad']['package'] = '0.6.2/nomad_0.6.2_linux_amd64.zip'
default['nomad']['checksum'] = 'fbcb19a848fab36e86ed91bb66a1602cdff5ea7074a6d00162b96103185827b4'



#
# VAULT
#

default['hashicorp-vault']['version'] = '0.8.2'

default['hashicorp-vault']['config']['habackend_type'] = 'consul'
default['hashicorp-vault']['config']['habackend_options']['address'] = '127.0.0.1:8500'
default['hashicorp-vault']['config']['habackend_options']['check_timeout'] = '10s'
default['hashicorp-vault']['config']['habackend_options']['disable_registration'] = false
default['hashicorp-vault']['config']['habackend_options']['path'] = 'vault/'
default['hashicorp-vault']['config']['habackend_options']['scheme'] = 'http'

default['hashicorp-vault']['config']['tls_disable'] = true
