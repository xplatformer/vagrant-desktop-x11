# -*- mode: ruby -*-
# vi: set ft=ruby :

dir = Dir.pwd
vagrant_dir = File.expand_path(File.dirname(__FILE__))

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.forward_agent = true

  config.vm.box = "bento/ubuntu-16.04"
  config.vm.hostname = "ubuntu-xenial"
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.memory = "2048"
  end
  
  # Provisioning
  #
  # Process one or more provisioning scripts depending on the existence of custom files.

  #
  # provison-pre.sh
  #
  # provison-pre.sh acts as a pre-hook to the default provisioning script. Anything that
  # should run before the shell commands laid out in bootstrap.sh (or your provision-custom.sh
  # file) should go in this script. If it does not exist, no extra provisioning will run.
  if File.exists?(File.join(vagrant_dir,'provision','provision-pre.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-pre.sh" )
  end

  #
  # bootstrap.sh
  #
  # By default, our Vagrantfile is set to use the bootstrap.sh bash script located in the
  # provision directory. If it is detected that a provision-custom.sh script has been
  # created, it is run as a replacement. This is an opportunity to replace the entirety
  # of the provisioning provided by the default bootstrap.sh.
  config.vm.provision :shell, :path => File.join( "provision", "bootstrap.sh" )

  #
  # provision-post.sh
  #
  # provision-post.sh acts as a post-hook to the default provisioning. Anything that should
  # run after the shell commands laid out in bootstrap.sh or provision-custom.sh should be
  # put into this file. This provides a good opportunity to install additional packages
  # without having to replace the entire default provisioning script.
  if File.exists?(File.join(vagrant_dir,'provision','setup.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "setup.sh" )
  end

  # Reboot after installation to ensure UI is visible
  config.vm.provision :shell, inline: "reboot"
end