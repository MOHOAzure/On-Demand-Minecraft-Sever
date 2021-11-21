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
There should be a server.jar
```
* CMD
```
mkdir -p /opt/minecraft/server/
cd /opt/minecraft/server
wget https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar
```

## Start Server after machine is started
* Expected result
```
For security concerns, make a dedicated user, named minecraft, to manage mc server.
The starting script is coded in system service file.
When the server machine is running, the user start mc server as well.
```
* CMD
```
$ groupadd -r minecraft
$ useradd -r -g minecraft -d "/var/minecraft" -s "/bin/bash" minecraft
$ chown minecraft.minecraft -R /var/minecraft/
$ 
$ # create a system service file, the content is presented in the following section
$ nano /etc/systemd/system/minecraft.service
$ 
$ chmod 644 /etc/systemd/system/minecraft.service
$ systemctl daemon-reload
$ systemctl enable minecraft
$ 
$ # optional : manully check server could be started
$ systemctl start minecraft
$ systemctl status minecraft -l
$ systemctl stop minecraft
$
$ # optional : check server could be auto started
$ # stop the machine then start it again, login server via MC launcher
```

* minecraft.service
```
[Unit]
Description=Minecraft Server

Wants=network.target
After=network.target

[Service]
User=minecraft
Group=minecraft
Nice=5
KillMode=control-group
SuccessExitStatus=0 1

ProtectHome=true
ProtectSystem=full
PrivateDevices=true
NoNewPrivileges=true
PrivateTmp=true
InaccessibleDirectories=/root /sys /srv -/opt /media -/lost+found
ReadWriteDirectories=/var/minecraft/server
WorkingDirectory=/var/minecraft/server
ExecStart=/usr/bin/java -Xms7G -Xmx15G -XX:ParallelGCThreads=6 -jar server.jar nogui

[Install]
WantedBy=multi-user.target
```

## Ref
* minecraft-systemd-service-file, WilhelmRoscher, https://github.com/WilhelmRoscher/minecraft-systemd-service-file
* Minecraft Server - Autostart using systemd - Linux Beginner Friendly, Wilhelm Roscher,https://www.youtube.com/watch?v=tNyN2LmaRVA
* How to Run a Minecraft Server on AWS For Less Than 3 US$ a Month, Julien Bras, https://dev.to/julbrs/how-to-run-a-minecraft-server-on-aws-for-less-than-3-us-a-month-409p
