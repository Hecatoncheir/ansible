FROM alpine

RUN apk add --update python3 py3-pip
RUN apk add python3-dev build-base --update-cache
RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev cargo

RUN pip install --upgrade setuptools         && \
    pip install --upgrade pycrypto           && \
    pip install --upgrade cffi pywinrm

RUN python3 -m pip install --user https://github.com/ansible/ansible/archive/stable-2.9.tar.gz

ENV PATH="/root/.local/bin:${PATH}"

RUN ansible --version

RUN echo "===> Adding hosts for convenience..."     && \
    mkdir -p /etc/ansible                           && \
    echo 'localhost' > /etc/ansible/hosts

CMD [ "ansible-playbook", "--version" ]
