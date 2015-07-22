FROM debian:wheezy
RUN apt-get update && apt-get install -y sudo git
EXPOSE 3000
