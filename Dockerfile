FROM centos:7
# enable centos plus repo and install epel repo
RUN sed -i '0,/enabled=.*/{s/enabled=.*/enabled=1/}' /etc/yum.repos.d/CentOS-Base.repo

RUN yum install -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

RUN yum update -y



# install necessary utilities
RUN yum install -y which tar
RUN yum install -y postgresql-libs postgresql-devl libpqxx-devel

# install rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -L get.rvm.io | bash -s stable
RUN source /etc/profile.d/rvm.sh
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1.5"
ENV PATH /usr/local/rvm:$PATH

#set default ruby version 
RUN /bin/bash -l -c "rvm use 2.1.5"
RUN /bin/bash -l -c "rvm gemset create rails_centos_docker"
RUN /bin/bash -l -c "rvm gemset use rails_centos_docker"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

ADD . /rails_centos_docker
WORKDIR /rails_centos_docker

RUN /bin/bash -l -c "bundle install"
RUN /bin/bash -l -c "rvm gemset list"
