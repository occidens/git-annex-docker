FROM debian:stable-slim

# References
# https://git-annex.branchable.com/install/Docker/
# https://github.com/sebastianhutter/docker-gitannex
# https://github.com/alphazo/docker-git-annex

ENTRYPOINT ["/usr/bin/git-annex"]
CMD ["version"]

#VOLUME /sourcedir /backupdir
WORKDIR /git-annex

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y \
        git-annex \
	&& apt-get clean -y

