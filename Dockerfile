FROM python

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app
COPY . .

# Since Python subprocesses by dotbot cannot do that if we set it in install.conf.yaml, we set it here.
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/root/.local/bin:${PATH}"  

# Set the default command to run the install script and then the test script
CMD ["/bin/bash", "-c", "./install && ./test"]