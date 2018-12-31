#!/bin/bash
toadd='        "DriverName": "postgres",
        "DataSource": "postgres://mmuser:your_password_here@localhost:5432/mattermost?sslmode=disable\u0026connect_timeout=10",'
cat <(head -n$(grep -n "SqlSe" config.json | sed 's/:.*//') /opt/mattermost/config/config.json) <(echo -e $toadd) <(tail -n
+$(( $(grep -n "SqlSe" config.json | sed 's/:.*//') + 2 ))) | sponge > /opt/mattermost/config/config.json
