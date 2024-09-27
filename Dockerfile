FROM ubuntu:latest

# Update and install dependencies
RUN apt-get update -y && \
    apt-get install -y python3 python3-pip python3-dev build-essential python3-venv && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the application code
COPY . /app

# Create a virtual environment and activate it
RUN python3 -m venv venv

# Install Python dependencies within the virtual environment
RUN ./venv/bin/pip install --no-cache-dir -r requirements.txt

# Ensure the virtual environment is activated when the container runs
ENV PATH="/app/venv/bin:$PATH"

# Set the FLASK_APP environment variable
ENV FLASK_APP="hello.py"

# Set the entry point to use Python3
# ENTRYPOINT ["python3"]
CMD ["flask", "run", "-h", "0.0.0.0"]