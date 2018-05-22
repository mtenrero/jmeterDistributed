# !/bin/bash
#### Description: Start up Jmeter in the mode specified
#### MODES: master / node
#### Master mode requires a REMOTES env with the list of the remote nodes
#### Written by: Marcos Tenrero on 11-2017

MODE=$MODE
RMI_PORT=$RMI_PORT
JMX=$JMX
REMOTES=$REMOTES

_node(){
    cd ../apache-jmeter*
    cd bin
    ./jmeter-server -Dserver.rmi.localport=4445 -Dserver_port=1099 
}

_master(){
    cd ../apache-jmeter*
    cd bin
    ./jmeter -n -t /test/$TEST_NAME.jmx -R$REMOTES -Dserver.rmi.localport=60000
    ./shutdown.sh
}

if [ "$MODE" == "master" ] 
then
    echo "MASTER/SINGLE mode"
    _master
elif [ "$MODE" == "node" ] 
then
    echo "NODE/SLAVE mode"
    _node
else
    echo "No valid mode detected, master/node in env MODE, exiting..."
    exit 1
fi

