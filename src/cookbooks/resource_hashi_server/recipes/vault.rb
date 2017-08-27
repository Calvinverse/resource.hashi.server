# frozen_string_literal: true

#
# Cookbook Name:: resource_hashi_server
# Recipe:: vault
#
# Copyright 2017, P. van der Velde
#

# Configure the service user under which vault will be run
poise_service_user node['hashicorp-vault']['service_user'] do
  group node['hashicorp-vault']['service_group']
end

directory '/etc/vault' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory '/etc/vault/conf.d' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

file '/etc/vault/server.hcl' do
  action :create
  content <<~HCL
    backend "consul" {
      address = "127.0.0.1:8500"
      path = "vault/"
      scheme = "http"
    }

    ha_backend "consul" {
      disable_clustering = "false"
    }
  HCL
end

#
# INSTALL VAULT
#

# This installs vault as follows
# - Binaries: /usr/local/bin/vault
# - Configuration: /etc/vault/vault.json
vault_installation node['hashicorp-vault']['version'] do |r|
  node['hashicorp-vault']['installation']&.each_pair { |k, v| r.send(k, v) }
end

# Create the systemd service for nomad. Set it to depend on the network being up
# so that it won't start unless the network stack is initialized and has an
# IP address
systemd_service 'vault' do
  action :create
  after %w[network-online.target]
  description 'Vault'
  documentation 'https://vaultproject.io'
  install do
    wanted_by %w[multi-user.target]
  end
  service do
    exec_start '/usr/local/bin/vault server -config=/etc/vault/server.hcl -config=/etc/vault/conf.d'
    restart 'on-failure'
  end
  requires %w[network-online.target]
end

# Make sure the nomad service doesn't start automatically. This will be changed
# after we have provisioned the box
service 'vault' do
  action :disable
end

#
# ALLOW VAULT THROUGH THE FIREWALL
#
firewall_rule 'vault-http' do
  command :allow
  description 'Allow Vault HTTP traffic'
  dest_port 8200
  direction :in
end

firewall_rule 'vault-cluster-http' do
  command :allow
  description 'Allow Vault cluster HTTP traffic'
  dest_port 8201
  direction :in
end
