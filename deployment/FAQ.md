# This doc will answer general questions


# How can I create local hosts name?

On your local machine, depending on the OS, add resolver entries to the hosts file.
In linux this is typically located on `/etc/hosts`

To associate ip address with a domain name, add entry to hosts file like this:

```
<ip address> <domain name>
``` 

for example

```
192.168.1.10 fbf.test
```

Will map `fbf.test` to ip address `192.168.1.10`
