# -*- mode: ruby -*-
# vi: set ft=ruby :

dir = Dir.pwd
vagrant_dir = File.expand_path(File.dirname(__FILE__))

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.forward_agent = true

  # Configuration
  #
  # Configurations for virtualbox provider
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.hostname = "ubuntu-xenial"
  config.vm.provider :virtualbox do |vb|
    vb.gui = true

    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
  end
  
  # Provisioning
  #
  # Process provisioning scripts depending on the existence of custom files.

  # provison-pre.sh
  #
  # provison-pre.sh acts as a pre-hook to the default provisioning script. Anything that
  # should run before the shell commands laid out in provision.sh should go in this script. 
  if File.exists?(File.join(vagrant_dir,'provision','provision-pre.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-pre.sh" )
  end

  # provision.sh or provision-custom.sh
  #
  # By default, our Vagrantfile is set to use the provision.sh bash script located in the
  # provision directory. The provision.sh bash script provisions the desktop environment.
  # If it is detected that a provision-custom.sh script has been created, it is run as a replacement. 
  if File.exists?(File.join(vagrant_dir,'provision','provision-custom.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-custom.sh" )
  else
    config.vm.provision :shell, :path => File.join( "provision", "provision.sh" )
  end

  # bootstrap.sh
  #
  # bootstrap.sh acts as a post-hook to the desktop environment provisioning. Anything that should
  # run after the shell commands laid out in provision.sh or provision-custom.sh should be
  # put into this file. This provides the method to install packages related to development.
  if File.exists?(File.join(vagrant_dir,'provision','setup.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "bootstrap.sh" )
  end

  # Reboot after installation
  config.vm.provision :shell, inline: "reboot"
end