# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "vagrant-omnibus-berkshelf"
  config.vm.box = "precise64_squishy"
  config.vm.box_url = "https://s3-us-west-2.amazonaws.com/squishy.vagrant-boxes/precise64_squishy_2013-02-09.box"

  config.vm.network :private_network, ip: "172.16.1.1"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  # I'm just using Berkshelf so that I don't have to muck with cookbook paths
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.log_level = "debug"
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      }
    }

    chef.run_list = [
        "recipe[vagrant-omnibus::default]"
    ]
  end
end
