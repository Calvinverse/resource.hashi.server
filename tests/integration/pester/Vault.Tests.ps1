Describe 'The vault application' {
    Context 'is installed' {
        It 'with binaries in /usr/local/bin' {
            '/usr/local/bin/nomad' | Should Exist
        }

        It 'with default configuration in /etc/vault/server.hcl' {
            '/etc/vault/server.hcl' | Should Exist
        }

        It 'with environment configuration in /etc/vault/conf.d' {
            '/etc/vault/conf.d/connections.hcl' | Should Exist
            '/etc/vault/conf.d/region.hcl' | Should Exist
        }
    }

    Context 'has been daemonized' {
        It 'with a systemd service' {
            '/etc/systemd/system/vault.service' | Should Exist

            <#

            [Unit]
            Description=Vault
            Requires=network-online.target
            After=network-online.target
            Documentation=https://vaultproject.io

            [Install]
            WantedBy=multi-user.target

            [Service]
            ExecStart=/usr/local/bin/vault server -config=/etc/vault/server.hcl -config=/etc/vault/conf.d
            Restart=on-failure

            #>
        }

        It 'and is running' {

        }
    }

    Context 'can be contacted' {
        # Verify vault ports?
        # Verify that vault is reachable from the outside
    }

    Context 'has linked to consul' {

    }
}
