# frozen_string_literal: true

#
# Cookbook Name:: resource_hashi_server
# Recipe:: default
#
# Copyright 2017, P. van der Velde
#

# Always make sure that apt is up to date
apt_update 'update' do
  action :update
end

#
# Include the local recipes
#

include_recipe 'resource_hashi_server::firewall'
include_recipe 'resource_hashi_server::consul'
include_recipe 'resource_hashi_server::network'
include_recipe 'resource_hashi_server::nomad'
include_recipe 'resource_hashi_server::vault'
include_recipe 'resource_hashi_server::provisioning'
