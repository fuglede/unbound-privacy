FROM alpine
EXPOSE 53/tcp 53/udp
RUN apk update && apk add --no-cache unbound ca-certificates && unbound-anchor
COPY unbound.conf /etc/unbound/unbound.conf
RUN wget -qO- https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | grep '^0\.0\.0\.0' | awk '{print "\tlocal-zone: \""$2"\" redirect\n\tlocal-data: \""$2" A 0.0.0.0\""}' >> /etc/unbound/unbound.conf
CMD /usr/sbin/unbound -d
