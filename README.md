# Unbound privacy

This is a Docker image for setting up a privacy-friendly Unbound DNS server. It is intended primarily for people residing in Denmark but can be used by anyone.

By running an instance of this on your home network, you will

* resolve names significantly faster as DNS queries get cached, thus speeding up ordinary web usage,
* automatically block malware and adware for all users on the network, including for instance mobile phones and smart TVs,
* circumvent the censorship exercised by Danish internet provides through their extensive use of DNS blocking/filtering, and
* encrypt all DNS queries that leave your network, where they would ordinarily be sent in cleartext to your internet provider. (But do note that your provider will still be able to find the hostnames of sites you are browsing through TLS SNI inspection.)


## Technical details

To achieve all of the above, we

* rely on [Steven Black's malware/adware list](https://github.com/StevenBlack/hosts) and block all of its contents at the DNS level by letting the DNS server resolve each entry on the list to 0.0.0.0, we
* forward all non-cached DNS queries using DNS-over-TLS to [UncensoredDNS](https://blog.uncensoreddns.org/), and we
* use Alpine Linux as our base image to minimize the footprint of running containers.


## Usage

The image can be run directly from Docker Hub through

```
$ docker run -d -p 53:53 -p 53:53/udp fuglede/unbound-privacy 
```

From there, if you are running this on your home network, you may wish to configure your router to use it as its default DNS server. If you just want to use the server from a single device, configure its network settings to use the IP of the server for DNS lookups. Another possible use case is to run a container on your local machine, and then configure it to use localhost as a DNS server.
