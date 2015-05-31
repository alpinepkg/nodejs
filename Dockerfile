FROM alpine

RUN apk --update update \
  && apk upgrade \
  && apk add alpine-sdk \
  && adduser -G abuild -g "Alpine Package Builder" -s /bin/sh -D builder \
  && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER builder

ENTRYPOINT ["abuild", "-r"]

WORKDIR /package

ENV PACKAGER_PRIVKEY /package/abuild.rsa
ENV REPODEST /packages
ENV PACKAGER Glider Labs <team@gliderlabs.com>

RUN abuild-keygen -a -i
RUN abuild-apk update
COPY . /package
RUN sudo mkdir /packages \
  && sudo chown -R builder /package /packages
