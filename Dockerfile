# set base OS image
FROM centos:latest

# set Ruby installed Dir
ENV RUBY_DIR /ruby/
ENV RUBY_VERSION 2.3.1
ENV RUBY_INSTALL $RUBY_DIR/$RUBY_VERSION

# install packeges for installing Ruby
RUN yum update -y && \
    yum install -y install epel-release && \
    yum install -y bzip2 make which wget tar git nodejs \
    gcc patch readline-devel zlib-devel \
    libyaml-devel openssl-devel \
    gdbm-devel ncurses-devel libxml-devel
RUN yum clean all

# install Ruby with ruby-build
RUN mkdir $RUBY_DIR && \
    cd $RUBY_DIR    && \
    git clone https://github.com/sstephenson/ruby-build.git && \
    $RUBY_DIR/ruby-build/install.sh                         && \
    cd $RUBY_DIR/ruby-build && ./bin/ruby-build $RUBY_VERSION $RUBY_INSTALL && \
    rm -rf $RUBY_DIR/ruby-build
ENV PATH $RUBY_INSTALL/bin:$PATH
