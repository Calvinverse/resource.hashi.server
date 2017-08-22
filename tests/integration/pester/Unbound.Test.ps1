Describe 'The unbound application' {
    Context 'is installed' {
        It 'with binaries in /usr/local/bin' {
            '/usr/local/bin/unbound' | Should Exist
        }

        It 'with default configuration in /etc/unbound' {
            '/etc/vault/server.hcl' | Should Exist
        }

        It 'with environment configuration in /etc/unbound.d' {
            '/etc/unbound./unbound_zones.conf' | Should Exist
        }
    }

    Context 'has been daemonized' {
        It 'with a systemd service' {
            '/etc/systemd/system/unbound.service' | Should Exist

            <#

            [Unit]
            Description=Unbound DNS proxy
            Requires=multi-user.target
            After=multi-user.target
            Documentation=http://www.unbound.net

            [Install]
            WantedBy=multi-user.target

            [Service]
            ExecStart=/usr/sbin/unbound -d -c /etc/unbound/unbound.conf
            Restart=on-failure

            #>
        }

        It 'and is running' {

        }
    }
}
