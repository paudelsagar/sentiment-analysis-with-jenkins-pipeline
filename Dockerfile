# Comes with debian base image
# FROM python:3.7
# Comes with alpine base image
# FROM python:3.7-alpine
# Comes with alpine base image
# FROM python:3.7-rc-alpine
# Comes with debian base image
FROM python:3.7-slim

# lets the command being executed inside directory given, here /app.
# If the path does not exist it is created inside the container.
WORKDIR /app

# Copy everyting to /app directory of container.
COPY . /app

# System Dependencies
RUN apt-get update -y
RUN apt-get install build-essential -y
RUN apt-get install curl -y

# Python dependencies
RUN apt-get install python-dev -y
RUN apt-get install default-libmysqlclient-dev -y

# Oracle dependencies
# RUN curl --output oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm
# RUN apt-get install libaio1 -y
# RUN apt-get install alien -y
# RUN alien -i --scripts oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm
# RUN rm oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm

# Installing python packages
RUN pip install --no-cache --upgrade pip setuptools
RUN pip install --no-cache -r requirements.txt
RUN python -m nltk.downloader punkt

# Expose port the port of container to host.
EXPOSE 4000

# ENTRYPOINT allows you to set commands and parameters and then use either
# form of CMD to set additional parameters that are more likely to be changed.
# ENTRYPOINT arguments are always used, while CMD ones can be overwritten by
# command line arguments provided when Docker container runs.
# ENTRYPOINT ["executable", "param1", "param2", ..]
ENTRYPOINT  ["python"]

# Set additional parameters that are more likely to be changed.
# CMD ["param1", "param2", ..]
CMD ["app.py"]