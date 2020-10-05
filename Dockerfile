FROM jenkins/ssh-agent

RUN apt-get update 
RUN apt-get install -y git wget apt-transport-https ca-certificates curl

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update
RUN apt-get install -y nodejs yarn default-jre
