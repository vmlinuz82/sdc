# SymfonyCast's API Platform 3 Part 1: Mythically Good RESTful APIs Toutorial Code
This is my code learning API Platform based on Docker compose simple development environment from https://github.com/vmlinuz82/tinkers-bench 

## Requirements

The latest versions of **Docker** and **Docker Compose** should be installed. Please follow the instructions given on [docs.docker.com](https://docs.docker.com/install/linux/docker-ce/ubuntu/). Additionally, you need to have Git installed on your system. We hope that the system administrators have already installed it.


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

## Starting and Stopping Project

First, stop all existing docker containers if there are any active to prevent conflicts on port 80.

```bash
docker stop $(docker ps -aq)
```

```bash
docker-compose up
```

in your terminal to start the development environment. 

You can use **CTRL+C** to stop Symfony Development Containers.

## Working with project

Now you can access your application at https://app.test and PHPMyAdmin on http://localhost:8080.

If you want to run some Symfony console commands, you need to connect to Tinker's Bench app container and run them there, like so:

```bash
docker exec -it -u 1000 apiplatform.app bash
```