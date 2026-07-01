require 'yaml'
config_data = YAML.safe_load_file(File.join(__dir__, 'config.yaml'))

Vagrant.configure("2") do |config|
  config.vm.box = config_data['box_name']

  all_groups = {}
  config_data['vms'].each do |vm|
    if vm['ansible_groups']
      vm['ansible_groups'].each do |group_name|
        all_groups[group_name] ||= []
        all_groups[group_name] << vm['name']
      end
    end
  end

  config_data['vms'].each do |vm|
    config.vm.define vm['name'] do |node|
      node.vm.hostname = vm['name']
      node.vm.network "private_network", ip: "#{config_data['subnet']}#{vm['ip_suffix']}"
      
      node.vm.provider "virtualbox" do |vb|
        vb.memory = vm['mem'] 
        vb.cpus = vm['cpus'] 
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      end

      if vm['provision_type'] == 'ansible'
        node.vm.provision "ansible" do |ansible|
          ansible.playbook = vm['playbook']
          ansible.groups = all_groups
        end
      end

    end
  end
end