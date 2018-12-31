#!/bin/bash
service postgresql restart
service --status-all
su postgres -c "psql < sql.commands"
