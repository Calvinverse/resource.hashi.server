# frozen_string_literal: true

#
# Cookbook Name:: resource_hashi_server
# Recipe:: provisioning
#
# Copyright 2017, P. van der Velde
#

service 'provision.service' do
  action [:enable]
end
