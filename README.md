# resource.hashi.server

This repository contains the code used to build an Ubuntu Hyper-V VM hard disk containing the server
instances of the core infrastructure application, [Consul](https://consul.io).

## Image

The image is created by using the [Linux base image](http://tfs:8080/tfs/Vista/DevInfrastructure/_git/Template-Resource.Linux.Ubuntu.Server)
and amending it using a [Chef](https://www.chef.io/chef/) cookbook which configures Consul.

### Contents

No additional applications are installed other than the ones that have been installed by
the base image.

### Configuration

No additional configuration is applied other than the default one for the base image.

### Provisioning

No changes to the provisioning are applied other than the default one for the base image.

### Logs

No additional configuration is applied other than the default one for the base image.

### Metrics

No additional configuration is applied other than the default one for the base image.

## Build, test and release

The build process follows the standard procedure for
[building Calvinverse images](https://www.calvinverse.net/documentation/how-to-build).

## Deploy

* Download the new image to the Hyper-V hosts. The image should be distributed over at least three
  different Hyper-V hosts if possible to ensure that a suitable number of Consul server instances
  are running at all times.
* Create a new directory in a suitable location and copy the image VHDX file there.
* Create a VM that points to the image VHDX file with the following settings
  * Generation: 2
  * RAM: 1024 Mb. Do *not* use dynamic memory
  * Hard disk: Use existing. Copy the path to the VHDX file
* Update the VM settings:
  * Enable secure boot. Use the Microsoft UEFI Certificate Authority
  * Attach a DVD image that points to an ISO file containing the settings for the environment. These
    are normally found in the output of the [Calvinverse.Infrastructure](https://github.com/Calvinverse/calvinverse.infrastructure)
    repository. Pick the correct ISO for the task, in this case the `Linux Consul Server` image
  * Disable checkpoints
  * Set the VM to always start
  * Set the VM to shut down on stop
* Start the VM, it should automatically connect to the correct environment once it has provisioned
* SSH into both the new VM and one of the other ServiceHub VMs
* Compare the `consul info` applied index stats. Once they have the same values the new machine is
  synced up. It is now safe to remove one of the other VMs
* SSH into the first host and give the `consul leave` command.
  Once that completes successfully you can shut the VM down by issueing the `sudo shutdown now`
  command. Then wait for it to shut down
* Once the VM has been shutdown it can be deleted and replaced with a new VM based on the new
  image.
* Repeat until all old instances have been replaced with new instances
