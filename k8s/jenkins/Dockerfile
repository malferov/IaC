FROM jenkins/jenkins:lts
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
RUN install-plugins.sh github-branch-source workflow-aggregator
USER root
RUN apt-get update && apt-get install -y apt-transport-https && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install -y kubectl
RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -aG docker jenkins
USER jenkins
