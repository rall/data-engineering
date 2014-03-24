# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "hashicorp/precise32"

    config.librarian_chef.cheffile_dir = "chef"

    config.vm.network :forwarded_port, guest: 3000, host: 3000

    config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "chef/cookbooks"


        chef.add_recipe "apt"
        chef.add_recipe "build-essential"
        chef.add_recipe "ruby_build"
        chef.add_recipe "rbenv::user"
        chef.add_recipe "rbenv::vagrant"
        chef.add_recipe "sqlite"

        chef.json = {
            'rbenv' => {
                'user_installs' => [
                    {
                        'user'    => 'vagrant',
                        'rubies'  => ['2.1.1'],
                        'global'  => '2.1.1',
                        'gems'    => {
                            '2.1.1' => [
                                {
                                    'name' => 'bundler',
                                    'version' => '1.5.3'
                                }
                            ]
                        }
                    }
                ]
            }
        }
    end

    config.vm.provision :shell, :inline => %q{chown -R vagrant:vagrant /home/vagrant/.rbenv}
    config.vm.provision :shell, :inline => %q{apt-get install libsqlite3-dev}
end
