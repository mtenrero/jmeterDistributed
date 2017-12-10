# jmeterDistributed
Docker Image with Jmeter and OpenJDK JRE based on Linux Alpine specially designed for distributed load testing

## Building the image
In order to build the image, you should run the following command:
`docker build -t mtenrero/jmeter -t mtenrero/jmeter:latest -t mtenrero/jmeter:3.3 .`
Please, bear in mind that the tags *:latest* and *:3.3* represents the version of Jmeter you're installing into the image

## Running the image
The image can be started in two modes:

- **Master** Represents the main instance of Jmeter, and should be started after the nodes. Also a environment variable **_REMOTES_** should be specified in the `docker run` command with the list of all available remotes to use by the master. `docker run -it -v $(pwd)/test:/test -e MODE="master" -e TEST_NAME="test.jmx" -e REMOTES="hosts" -p 6666:6666 mtenrero/jmeter`
- **Node** It's a worker in the distributed load testing process. `docker run -d -e MODE="node" -p 7777:7777 -p 1099:1099 -p 4445:4445 mtenrero/jmeter`

## Docker Compose
Docker Compose is the easiest way to try the configuration locally. You only need to specify the test name without the JMX extension in the enviroment variable *TEST_NAME* and put the file under the test folder within the root docker-compose folder.

If you need simulate multiple nodes, clone the slaves in the docker-compose file and make sure that they are declared in the REMOTES env.

`TEST_NAME=abvetmadrid docker-compose up`

## Ports
- **4445** Jmeter communication port
- **7777** RMI Port
- **1099** Master Port

## Roadmap
- [x] Basic Image for running distributed tests
- [x] Docker-compose for local debugging
- [ ] Publish to Docker Hub
- [ ] CI/CD
- [ ] Docker-compose v3 improvements
- [ ] Fix non-ending slaves