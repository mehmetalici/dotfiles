# Use an official Python image as the base
FROM python

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt update && \
    apt install -y sudo software-properties-common python3-launchpadlib

# Create a user 'testuser' and set a default password via environment variable
# The default password is 'pass', but it can be overridden by the USER_PASSWORD environment variable
RUN useradd -ms /bin/bash testuser && \
    echo "testuser:testpass" | chpasswd && \
    adduser testuser sudo

# Ensure passwordless sudo for 'testuser'
RUN echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/testuser && \
    chmod 0440 /etc/sudoers.d/testuser

# Switch to 'testuser' for further operations
USER testuser

# Create the working directory for 'testuser'
WORKDIR /home/testuser/app

# Copy the current directory contents into the container, preserving ownership for 'testuser'
COPY --chown=testuser:testuser . .

# Set the PATH environment variable for the user
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/testuser/.local/bin:${PATH}"

# Set the default command to run the install script and then the test script
CMD ["/bin/bash", "-c", "./install && ./test"]
