# Local Domain Name Setup

In order to provide DNS name resolutions service there are several possible approach to take.
Our recommended approach is using [Using extra_hosts docker-compose options](#Use-extra_hosts-docker-compose-options)

We will explain it with pros and cons for each of them


## Use /etc/hosts

*Pros*

- Easy to setup in Unix-like environment (covers Linux and Mac)
- Easy to use for beginner, you only need to edit a file
- No need to install extra applications/daemons

*Cons*

- Different IP if you connect with different interfaces
- Different IP if you connect with different interfaces

*Approach Summary*

In Unix-like environment, the OS usually have a file called `/etc/hosts` 
that can be used for internal name resolutions. We could use this file 
to map our associations between service name and IP address.
Usually docker engine will also includes `/etc/hosts` file of the host into it's containers.
If this is not the case, then we can add extra options in our service definition file.

*Steps*

1. Open `/etc/hosts` as administrator (it needs admin permissions to edit).

2. Add your name-ipaddress pairs like this, each item separated by white space.

```
<ipaddress> <name 1> <name 2>
```

for example:

```
172.17.0.1 fbf.test geoserver.fbf.test
```

<ipaddress> is the IP Address of the interface you want to bind your service into.
Conveniently, in Linux-based OS, Docker have a docker bridge interface called `docker0`.
The address is usually `172.17.0.1`, it is usually will not change, so you can use this address.

Mac-based OS doesn't have this, so you had to bind it to your interface IP Address.
Consequently, if you change network (change WIFI SSID, etc), the IP Address might change too.
This is inconvenient in a co-working space where the address gets rotated frequently.

 
## Use extra_hosts docker-compose options

*Pros*

- Easy to setup using docker-compose file config
- Easy to use for beginner, you only need to edit a file
- No need to install extra applications/daemons
- Readable configurations because it is embedded in the docker-compose config file

*Cons*

- Different IP address means you need to do the setup again
- You had to change your docker-compose file

*Approach Summary*

The principle of how it works is exactly the same with using `/etc/hosts` file.
However instead of changing the hosts file in the host, we change hosts file in the container itself.
We map hostname into ip address for each service that needs external service.

*Steps*

1. Change your docker-compose.override.yml file to include extra options like this.

For example, we add new hosts mappings for `geoserver` service.

The compose file is redacted to show only relevant keys.

```yaml
services:
  geoserver:
    extra_hosts:
      - "fbf.test:${LOCAL_HOST_IP_ADDRESS}"

```

If we go inside geoserver containers, pinging `fbf.test` will resolve to the 
ip address specified by `LOCAL_HOST_IP_ADDRESS` variable.
We use variable because it is common that you want configure multiple service
with the same ip address. In this case you are able to point all the same service 
into a single network interface and communicate by different port for different service.
It is a very convenient setup for single computer setup.

2. Alternatively, you can add the settings as extra compose file override.

If you prefer to add extra config file for maintainability, you can add more docker-compose file.
This case is makes sense if you want to always have docker-compose.override.yml value from the template.
In order for your own custom settings to not get overwritten, you create another docker-compose file.
Like this:

You make new file called `docker-compose.local.yml`
With the content only consists of your `extra_hosts` override, like this:

```yaml
version: '2.1'
services:
  geoserver:
    extra_hosts:
      - "fbf.test:${LOCAL_HOST_IP_ADDRESS}"

```

Then to make sure this new file is included in the configuration, you need to add new 
variable in your `.env` file.

```ini
COMPOSE_FILE=docker-compose.yml:docker-compose.override.yml:docker-compose.local.yml
```

With that ordering, that means your `docker-compose.local.yml` gets priority because it is included last.
Docker compose will read the config file in that order and replace previous key-value if it is defined again.

3 Find your interface IP Address.

You need to figure out your local machine IP Address so the address will be reachable by all of your containers and your host itself.
Conveniently, in Linux, there is a bridge network available for docker which is interface `docker0`.
This bridge usually have a fixed IP Address as `172.17.0.1` (It might be different if you have multiple bridge).
You can use this IP Address and it will not change (unless you change it).

In Mac however, there is no docker bridge. So you have to bind with your hardware interface. This can be your WIFI card or ethernet.
Find your interface ip address, usually using `ifconfig`.

4. Create key-value substitution for `LOCAL_HOST_IP_ADDRESS`

In the previous step, you only tell your compose file where to get the value, but it is not initialized.
There are two ways to initialize this.
You can put the key value in your `.env` file or you can just export it directly in your shell.

```bash
export LOCAL_HOST_IP_ADDRESS=<the ip address>
```

Then you can use that shell session to start your docker-compose stack.
For readability, of course it is more recommended to put it in your `.env` file.
However, unlike the docker-compose file, environment file can't be overridden by other environment file.


## Use DNS Resolver

*Pros*

- Very flexible and powerful
- Once off setup but for every project that needs name resolutions

*Cons*

- It is not easy to understand the concept
- The first setup is not trivial

*Approach Summary*

The idea here is to use actual name resolutions to resolve the address/hostname.
We setup local DNS server, preferably using dnsmasq and bind it to local interface.
We expose the service as DNS server thru port 53 (standard port for DNS resolver).
We ask every local interface that connect to use our DNS server, including docker container.
Then if the container tried to resolve a hostname, it will use your DNS server and resolve back local ip address.

*Steps*

These steps assumes that you know about DNS service in general.

1. Install DNS service

You can install dnsmasq or even uses Dockerized dnsmasq service, like https://github.com/jpillora/docker-dnsmasq.

2. Configure DNS service to resolve certain Top Level Domain.

For example, using dnsmasq.conf, you can configure that every domain name ends with `.test` will resolve to your interface IP Address.

```ini
# Default external DNS Service (1.1.1.1 is Cloudflare's DNS)
server=1.1.1.1
# Add your local machine as DNS Resolver for domain `.test`
server=/test/<the ip address>
# define domain to ip mappings
address=/test/<the ip address>
```

3. Make your local computer uses your DNS server

For Unix-like OS, you can add your DNS server in a config file called `/etc/resolv.conf`.
Note that you need admin access (sudo) to edit this file.

It is often that this file were autogenerated by the OS because the OS provides a GUI to change this settings.
In Mac/Linux you can set DNS server settings from the Network Preferences.

For more advanced usages you could create a script that edit this file, then run the script everytime you want to set local DNS.

When you set DNS Server for your host, all the docker containers will automatically uses your DNS Server specified by you.
So no matter what project it is, every docker-compose stack, every containers will resolve `*.test` host name to your local machine ip Address.
You don't need to change your compose file or environment variable.

*Notes*

Although this approach is very powerful, it is not recommended for beginner, because you are dealing with your OS directly.
There is no automatic way to make your local computer uses your DNS service that you set up.
There can be problems if you are not careful.
For example your DNS Server might clash if port 53 were already used by the OS.
Or, if you reconnect to a different Wi-Fi, then your local ip address also changes which makes you had to rebind your DNS Server to different IP Address.
If you set it up incorrectly, you might not be able to access the internet because your computer can't resolve the DNS service.
