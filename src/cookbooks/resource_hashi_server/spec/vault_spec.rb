# frozen_string_literal: true

require 'spec_helper'

describe 'resource_hashi_server::vault' do
  context 'creates the vault configuration files' do
    let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

    vault_client_config_content = <<~HCL
      backend "consul" {
        address = "127.0.0.1:8500"
        path = "vault/"
        scheme = "http"
      }

      ha_backend "consul" {
        disable_clustering = "false"
      }
    HCL
    it 'creates server.hcl in the vault configuration directory' do
      expect(chef_run).to create_file('/etc/vault/server.hcl')
        .with_content(vault_client_config_content)
    end
  end

  context 'configures vault' do
    let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

    it 'installs the vault service' do
      expect(chef_run).to create_systemd_service('vault').with(
        action: [:create],
        after: %w[network-online.target],
        description: 'Vault',
        documentation: 'https://vaultproject.io',
        requires: %w[network-online.target]
      )
    end

    it 'disables the vault service' do
      expect(chef_run).to disable_service('vault')
    end
  end

  context 'configures the firewall for consul' do
    let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

    it 'opens the Vault HTTP port' do
      expect(chef_run).to create_firewall_rule('vault-http').with(
        command: :allow,
        dest_port: 8200,
        direction: :in
      )
    end

    it 'opens the Vault cluster HTTP port' do
      expect(chef_run).to create_firewall_rule('vault-cluster-http').with(
        command: :allow,
        dest_port: 8201,
        direction: :in
      )
    end
  end
end
