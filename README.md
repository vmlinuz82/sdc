# Tinker's Bench
![Tinker's Bench](https://static.wikia.nocookie.net/fallout/images/8/85/FO76_Tinker_workbench.png/revision/latest?cb=20190322180727)

Tinker's Bench is a Docker Compose file along with some Docker and configuration files. It launches several containers responsible for running Symfony applications.

This repository can be used as a boilerplate for creating a containerized Symfony application for testing or learning. Simply fork this repository and start tinkering!

## Requirements

The latest versions of **Docker** and **Docker Compose** should be installed. Please follow the instructions given on [docs.docker.com](https://docs.docker.com/install/linux/docker-ce/ubuntu/). Additionally, you need to have Git installed on your system. We hope that the system administrators have already installed it.

## Initialize the working repository on the local system

Run the following command in your terminal:

```bash
git clone git@github.com:vmlinuz82/tinkers-bench.git [your_app_folder]
```

## Installation

### Create unique name for the project
You need to change PROJECT_NAME variable value in [.env](.env) file to project name you want.

### Resolving Domain app.test

To resolve the domain app.test, add the following to your **/etc/hosts** file:

```bash
127.0.0.1 app.test
```

### Adding a Self-Signed Certificate to Your Browser

To access our app.test site with the HTTPS scheme, you need to add a self-signed certificate to your browser's trusted authorities. You will need to import it manually. Here are some examples:

#### Google Chrome

- Open Chrome and go to [chrome://settings/certificates](chrome://settings/certificates).
- Go to the "Authorities" tab.
- Click on "Import" and select the tinkersbench.pem file from the certs folder in this repository.
- Check the box that says "Trust this certificate for identifying websites" and click "OK".

#### Mozilla Firefox

- Open Firefox and go to [about:preferences#privacy](https://app.test/).
- Scroll down to the "Certificates" section and click on "View Certificates".
- Go to the "Authorities" tab.
- Click on "Import" and select the tinkersbench.pem file from the certs folder in this repository.
- Check the box that says "Trust this CA to identify websites" and click "OK".

#### Safari

- Open the Keychain Access app (you can find it in the Utilities folder, inside the Applications folder).
- Drag the tinkersbench.pem file from the certs folder in this repository into the "Certificates" category in Keychain Access.
- Right-click on the imported certificate (listed under "Certificates" in the sidebar), then click "Get Info".
- Expand the "Trust" section, and beside "When using this certificate", choose "Always Trust".

## Starting and Stopping Tinker's Bench

First, stop all existing docker containers if there are any active to prevent conflicts on port 80.

```bash
docker stop $(docker ps -aq)
```

**:warning: Warning:**
**If you run it for the first time, then the app folder will be created and an empty Symfony 7 app will be created in it!**

If you want to change the symfony version you can do it as changing value of SYMFONY_VERSION env variable set in [start.sh](./configs/symfony/start.sh) file.

Now, you can go to the folder where you cloned Tinker's Bench and type:

```bash
docker-compose up
```

in your terminal to start the development environment. 

You can use **CTRL+C** to stop Symfony Development Containers.

## Working with Tinker's Bench

Now you can access your application at https://app.test and PHPMyAdmin on http://localhost:8080.

If you want to run some Symfony console commands, you need to connect to Tinker's Bench app container and run them there, like so:

```bash
docker exec -it -u 1000 tinkers-bench.app bash
```

Also, in the [compose.yaml](compose.yaml) file, there are commented services for Redis and Memcache. If you want to use them, uncomment the code and run `docker-compose up` again.