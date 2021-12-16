title: Lab 04 - Docker
---

## Lab 04 - Docker

0. [Identify issues and install the tools](#task-0)
1. [Add a process supervisor to run several processes](#task-1)
2. [Add a tool to manage membership in the web server cluster](#task-2)
3. [React to membership changes](#task-3)
4. [Use a template engine to easily generate configuration files](#task-4)
5. [Generate a new load balancer configuration when membership changes](#task-5)
6. [Make the load balancer automatically reload the new configuration](#task-6)

## Introduction

## Tâches

### Tâche 0

1. **[M1]** *Do you think we can use the current solution for a production environment? What are the main problems when deploying it in a production environment?*

- Pour ajouter un nouveau serveur, il est nécessaire de l'ajouter manuellement dans la  configuration de HAProxy
- Le système repose sur un seul proxy. En cas de forte demande, celui-ci peut aussi tomber

1. **[M2]** *Describe what you need to do to add new `webapp` container to the infrastructure. Give the exact steps of what you have to do without modifiying the way the things are done. Hint: You probably have to modify some configuration and script files in a Docker image.*

####  docker-compose.yml

Ajouter une webapp3 en modifiant les paramètres qui lui sont propres comme :

- Le nom du container
- Son adresse IP
- Son port

```yaml
   webapp3:
       container_name: ${WEBAPP_3_NAME}
       build:
         context: ./webapp
         dockerfile: Dockerfile
       networks:
         heig:
           ipv4_address: ${WEBAPP_3_IP}
       ports:
         - "4002:3000"
       environment:
            - TAG=${WEBAPP_3_NAME}
            - SERVER_IP=${WEBAPP_3_IP} 
```

Toujours dans le même fichier, ajouter dans la partie environnement  webapp3

```yaml
  environment:
            - WEBAPP_1_IP=${WEBAPP_1_IP}
            - WEBAPP_2_IP=${WEBAPP_2_IP}
            - WEBAPP_3_IP=${WEBAPP_3_IP}
```

#### haproxy.cfgc

Dans haproxy.cfgc, il faut ajouter le serveur 3 :

```bash
server s3 ${WEBAPP_3_IP}:3000 check
```

### .env

Dans le fichier .env, il faut ajouter également webapp_3

```.env
WEBAPP_1_NAME=s1
WEBAPP_2_NAME=s2
WEBAPP_3_NAME=s3

WEBAPP_1_IP=192.168.42.11
WEBAPP_2_IP=192.168.42.22
WEBAPP_3_IP=192.168.42.33

HA_PROXY_IP=192.168.42.42

NETWORK_SUBNET=192.168.42.0/24
```



1. **[M3]** *Based on your previous answers, you have detected some issues in the current solution. Now propose a better approach at a high level.*

2. **[M4]** *You probably noticed that the list of web application nodes is hardcoded in the load balancer configuration. How can we manage the web app nodes in a more dynamic fashion?*

3. **[M5]** *In the physical or virtual machines of a typical infrastructure we tend to have not only one main process (like the web server or the load balancer) running, but a few additional processes on the side to perform management tasks.*

   *For example to monitor the distributed system as a whole it is common to collect in one centralized place all the logs produced by the different machines. Therefore we need a process running on each machine that will forward the logs to the central place. (We could also imagine a central tool that reaches out to each machine to gather the logs. That's a push vs. pull problem.) It is quite common to see a push mechanism used for this kind of task.*

   *Do you think our current solution is able to run additional management processes beside the main web server / load balancer process in a container? If no, what is missing / required to reach the goal? If yes, how to proceed to run for example a log forwarding process?*

4. **[M6]** *In our current solution, although the load balancer configuration is changing dynamically, it doesn't follow dynamically the configuration of our distributed system when web servers are added or removed. If we take a closer look at the `run.sh` script, we see two calls to `sed` which will replace two lines in the `haproxy.cfg` configuration file just before we start `haproxy`. You clearly see that the configuration file has two lines and the script will replace these two lines.*

   *What happens if we add more web server nodes? Do you think it is really dynamic? It's far away from being a dynamic configuration. Can you propose a solution to solve this?*

**Deliverables :**

1. Take a screenshot of the stats page of HAProxy at [http://192.168.42.42:1936](http://192.168.42.42:1936/). You should see your backend nodes.

   ![HAProxy_StatPage](img/HAProxy_StatPage.PNG)

2. Give the URL of your repository URL in the lab report.

   URL du repo git : [https://github.com/Tchewi/AIT-Labo4-Docker-and-dynamic-scaling](https://github.com/Tchewi/AIT-Labo4-Docker-and-dynamic-scaling)

### Tâche 1

### Tâche 2

### Tâche 3

### Tâche 4

### Tâche 5



### Difficultés

### Conclusion