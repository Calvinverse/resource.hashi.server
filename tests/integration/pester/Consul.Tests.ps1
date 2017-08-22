Describe 'The consul application' {
    Context 'is installed' {
        It 'with binaries in /usr/local/bin' {
            '/usr/local/bin/consul' | Should Exist
        }

        It 'with default configuration in /etc/consul/consul.json' {
            '/etc/consul/consul.json' | Should Exist
        }

        It 'with environment configuration in /etc/consul/conf.d' {
            '/etc/consul/conf.d/bootstrap.json' | Should Exist
            '/etc/consul/conf.d/connections.json' | Should Exist
            '/etc/consul/conf.d/location.json' | Should Exist
            '/etc/consul/conf.d/region.json' | Should Exist
            '/etc/consul/conf.d/secrets.json' | Should Exist
        }
    }

    Context 'has been daemonized' {
        # Verify that the consul daemon is configured and is running

        It 'with a systemd service' {
            '/etc/systemd/system/consul.service' | Should Exist

            <#
            [Unit]
            Description=consul
            Wants=network.target
            After=network.target

            [Service]
            Environment="GOMAXPROCS=2" "PATH=/usr/local/bin:/usr/bin:/bin"
            ExecStart=/opt/consul/0.8.3/consul agent -config-file=/etc/consul/consul.json -config-dir=/etc/consul/conf.d
            ExecReload=/bin/kill -HUP $MAINPID
            KillSignal=TERM
            User=consul
            WorkingDirectory=/var/lib/consul

            [Install]
            WantedBy=multi-user.target
            #>
        }

        It 'and is running' {

        }
    }

    Context 'can be contacted' {
        # Verify consul ports?
        # Verify that consul is reachable from the outside
    }
}
