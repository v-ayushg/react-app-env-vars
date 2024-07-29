FROM node:alpine
ENV REACT_APP_MESSAGE=MyApp
WORKDIR /app/
COPY . /app/

RUN npm install
 
# Start and enable SSH
RUN apk add openssh \
     && echo "root:Docker!" | chpasswd \
     && chmod +x /app/init_container.sh \
     && cd /etc/ssh/ \
     && ssh-keygen -A

COPY sshd_config /etc/ssh/

EXPOSE 3000

ENTRYPOINT [ "/app/init_container.sh" ]