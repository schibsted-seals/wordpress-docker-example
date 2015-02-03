# wordpress-docker-example

### Requirements
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](http://www.vagrantup.com/downloads.html)
- Vagrant additions:

```
vagrant plugin install vagrant-vbguest
```

### Vagrant environment

Start vagrant with docker provider

```
vagrant up --provider=docker --no-parallel
```

Make copy of local-config.php.dist and save it as local-config.php. 
After that wordpress instance should be available under `http://192.168.33.15` and `http://localhost:8080`

#### Advanced configuration

You can change entry points in [proxy/Vagrantfile.proxy](https://github.com/schibsted-seals/wordpress-docker-example/blob/master/proxy/Vagrantfile.proxy)

First url is delivered with assigning ip to proxy machine:
```
config.vm.network "private_network", ip: "192.168.33.15"
```

later is available due to port forwarding:
```
config.vm.network "forwarded_port", guest: 80, host: 8080
```

In case of conflict you may want to change/disable port forwarding.

#### Custom domain

You can map fake domain to just created machine. To do this put following line into your `/etc/hosts`

```
192.168.33.15  mydomain.dev
```

#### Shell access

To connect with ssh use
```
vagrant ssh wordpress-example
```

password for default user is `123` and is configurable in [Dockerfile](https://github.com/schibsted-seals/wordpress-docker-example/blob/master/Dockerfile#L18)
