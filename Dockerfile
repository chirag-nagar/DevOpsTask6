FROM centos   

WORKDIR /minikube_client

# for kubenetes
COPY k8s.repo /etc/yum.repos.d/
RUN yum install kubectl -y
COPY ca.crt /minikube_client
COPY client.crt /minikube_client
COPY client.key /minikube_client
RUN mkdir /root/.kube/
COPY config /root/.kube/

# for jenkins
COPY jenkins.repo /etc/yum.repos.d/
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN yum install jenkins --nobest -y
RUN echo -e "jenkins 	ALL=(ALL) 	NOPASSWD: ALL" >>/etc/sudoers
RUN yum install java-11-openjdk.x86_64 -y

RUN yum install git -y
RUN yum install php -y
RUN yum install net-tools -y
RUN yum install initscripts -y

EXPOSE 8080
CMD java -jar /usr/lib/jenkins/jenkins.war 
