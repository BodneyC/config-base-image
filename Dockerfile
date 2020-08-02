FROM manjarolinux/base:latest as ROOT_PHASE

RUN mkdir /docker-build

COPY ./Dockerfile /docker-build/
COPY ./run-as-root.sh /docker-build/
COPY ./run-as-user.sh /docker-build/

USER 0

WORKDIR /docker-build
RUN /docker-build/run-as-root.sh

RUN useradd -d /home/benjc -m -u 1000 -s /bin/zsh benjc
RUN usermod -aG wheel benjc
RUN sed -i 's/# %wheel/%wheel/' /etc/sudoers

FROM ROOT_PHASE as USER_PHASE

USER 1000

RUN /docker-build/run-as-user.sh

CMD [ "/bin/zsh" ]
