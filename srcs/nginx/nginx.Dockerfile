FROM debian:buster-20220822

RUN ["/usr/bin/apt", "update"]
RUN ["/usr/bin/apt", "install", "-y", "nginx", "netcat"]
