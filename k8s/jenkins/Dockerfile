FROM jenkins/jenkins:lts
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
RUN install-plugins.sh github-branch-source workflow-aggregator
USER root
RUN apt-get update && apt-get -y install git curl openssh-client && \
RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -aG docker jenkins
USER jenkins
