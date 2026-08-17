ARG postgres
FROM ${postgres}

RUN localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8
ENV LANG pt_BR.utf8

RUN apt-get update
RUN apt-get -y install unzip wget ruby-full dos2unix

ARG relative_path
# RUN echo "Hello this is relative path client: ${relative_path}"
COPY ${relative_path}/install.sh /docker-entrypoint-initdb.d/

RUN mkdir /data
WORKDIR /data/

COPY ${relative_path}/install.sql .
COPY ${relative_path}/update_csvs.rb .
# COPY adventure_works_2014_OLTP_script.zip .

RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks-oltp-install-script.zip -O adventure_works_2014_OLTP_script.zip
RUN unzip adventure_works_2014_OLTP_script.zip
RUN rm adventure_works_2014_OLTP_script.zip 
RUN ruby update_csvs.rb
RUN rm update_csvs.rb

RUN dos2unix /docker-entrypoint-initdb.d/*.sh
