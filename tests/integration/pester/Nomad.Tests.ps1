Describe 'The nomad application' {
    Context 'is installed' {
        It 'with binaries in /usr/local/bin' {
            '/usr/local/bin/nomad' | Should Exist
        }

        It 'with default configuration in /etc/nomad-conf.d/server.hcl' {
            '/etc/nomad-conf.d/server.hcl' | Should Exist
        }

        It 'with environment configuration in /etc/nomad-conf.d' {
            '/etc/nomad-conf.d/bootstrap.hcl' | Should Exist
            '/etc/nomad-conf.d/connections.hcl' | Should Exist
            '/etc/nomad-conf.d/region.hcl' | Should Exist
            '/etc/nomad-conf.d/secrets.json' | Should Exist
        }
    }

    Context 'has been daemonized' {
        It 'with a systemd service' {
            '/etc/systemd/system/nomad.service' | Should Exist

            <#

            [Unit]
            Description=Nomad System Scheduler
            Requires=network-online.target
            After=network-online.target
            Documentation=https://nomadproject.io/docs/index.html

            [Install]
            WantedBy=multi-user.target

            [Service]
            ExecStart=/usr/local/bin/nomad agent -config=/etc/nomad-conf.d
            Restart=on-failure

            #>
        }

        It 'and is running' {

        }
    }

    Context 'can be contacted' {
        # Verify nomad ports?
        # Verify that nomad is reachable from the outside
    }

    Context 'has linked to consul' {
        # check that consul has the service
    }
}
