FROM haskell:latest

ARG GIT_ANNEX_VERSION=8.20200501

# References
# https://git-annex.branchable.com/install/Docker/
# https://github.com/sebastianhutter/docker-gitannex
# https://github.com/alphazo/docker-git-annex
# https://github.com/haskell/cabal/issues/6076
# https://daten-und-bass.io/blog/fixing-missing-locale-setting-in-ubuntu-docker-image/
RUN apt-get update \
	&& DEBIAN_FRONTENT=noninteractive apt-get install -y locales \
	&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
	&& dpkg-reconfigure --frontend=noninteractive locales \
	&& update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8 
ENV LC_ALL en_US.UTF-8

RUN git clone git://git-annex.branchable.com/ /git-annex --branch ${GIT_ANNEX_VERSION}

WORKDIR /git-annex

RUN stack setup
RUN stack build -j1
RUN make install BUILDER=stack PREFIX=/usr/local

ENTRYPOINT ["bash"]
