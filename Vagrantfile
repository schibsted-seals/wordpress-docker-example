VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.username="root"

  config.vm.define "mysql-wordpress-example" do |a|
    a.vm.provider "docker" do |d|
      d.name = "mysql-wordpress-example"
      d.build_dir = "./database"
      d.vagrant_vagrantfile = "./proxy/Vagrantfile.proxy"
      d.ports = [
        "3306:3306"
      ]
      d.volumes = [
        "/data/:/var/lib/mysql:rw"
      ]
    end
  end

  config.vm.define "wordpress-example" do |a|
    a.vm.provider "docker" do |d|
      d.name = "wordpress-example"
      d.build_dir = "."
      d.vagrant_vagrantfile = "./proxy/Vagrantfile.proxy"
      d.ports = [
        "80:80"
      ]
      d.create_args = [
        "--link",
        "mysql-wordpress-example:mysql"
      ]
      d.volumes = [
        "/vagrant/:/var/www:rw"
      ]
    end
  end
end
