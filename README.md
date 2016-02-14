# Master Of Puppets

This just demonstrate how you can provision and build sample go app in local environment.
* 3 ubuntu instances: 1 x Web(nginx) and 2 x App(GO)
* Using puppet to install and configure Nginx with round-robin and install app requirement on nodes.
* Using simple bash to build and run go app

![alt tag](diag.png)

## Dependencies

**Software dependencies.**

* VirtualBox
* Vagrant

## Running stack
For run and build web with 2x GO app just need to run:
```
make stack
```
So now you can check the stack from Nginx load-balancer from "http://localhost:8000" (by refreshing the page app message should be changed). Also it possible to connect to nodes app-1: "http://localhost:8001" app-2: "http://localhost:8002"

### Destroy stack
Run this command to destroy stack
```
make destroy_stack
```

## Running single node (web | app-1 | app-2)
If you need to run one of nodes and connect to vagrant machine via ssh you just need to run this command:
```
make machine ROLE=web
make machine ROLE=app-1
make machine ROLE=app-2
```
### Destroy node
```
make destroy_machine ROLE=web
make destroy_machine ROLE=app-1
make destroy_machine ROLE=app-2
```
