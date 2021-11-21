# Server Setup

## Connect to the machine
* ssh to machine
  * If you face key.pem permisson error on Windows system, then you could refer to 
    * remove inheritance permisson. CMD: icacls .\YOUR-KEY.pem /inheritance:r
    * re-assign permisson, e.g., https://blog.csdn.net/joshua2011/article/details/90208741 
* change to root account for ease of cmd

## Install Java 17
* Expected result
```
openjdk 17.0.1 2021-10-19 LTS
OpenJDK Runtime Environment Corretto-17.0.1.12.1 (build 17.0.1+12-LTS)
OpenJDK 64-Bit Server VM Corretto-17.0.1.12.1 (build 17.0.1+12-LTS, mixed mode, sharing)
```

* CMD
```
$ rpm --import https://yum.corretto.aws/corretto.key
$ curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
$ yum install -y java-17-amazon-corretto-devel.x86_64
$ java --version
```

## Install Minecraft
* Expected result
```
Install MC server at /var/minecraft/server/
```
* CMD
```
mkdir -p /opt/minecraft/server/
cd /opt/minecraft/server
wget https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar
```

## Ref
* minecraft-systemd-service-file, WilhelmRoscher, https://github.com/WilhelmRoscher/minecraft-systemd-service-file
* How to Run a Minecraft Server on AWS For Less Than 3 US$ a Month, Julien Bras, https://dev.to/julbrs/how-to-run-a-minecraft-server-on-aws-for-less-than-3-us-a-month-409p
