# Mattermost self-hosted, in a single Docker image

Prior to install you will need to modify some files. The main thing to do is to choose a database password. Let's say your password is `banana01` (please don't use that...). Then you shoud run (leave `your_password_here` unchanged):

```bash
password="banana01"
git clone https://github.com/agilly/mattermost_manual.git
cd mattermost_manual
sed -i 's/your_password_here/'$password'/' sql.commands
sed -i 's/your_password_here/'$password'/' set_config.sh
docker build -t mattermost-manual .
docker run -it -d -p 8065:8065 mattermost_compact ./start_server.sh
```

Any trouble, please let me know. In particular there is an untested one-liner in `set_config.sh`. You can replace this by editing `config.json` manually in the container.


