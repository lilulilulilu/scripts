# clear docker
apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt-get install     ca-certificates     curl     gnupg     lsb-release

# install docker
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#use docker to install mongo
docker pull mongodb/mongodb-community-server
docker run -itd --name mongo -p 27017:27017 mongodb/mongodb-community-server  --auth
docker exec -it mongo mongosh admin

# run mongo server
docker run -itd --name mongo -p 27017:27017 mongodb/mongodb-community-server  --auth

# connect mongo server with mongosh
docker exec -it mongo mongosh admin

# create a admin user, change the password
db.createUser({ user:'admin',pwd:'password',roles:[ { role:'userAdminAnyDatabase', db: 'admin'},"readWriteAnyDatabase"]});
db.changeUserPassword('admin','password');
# check password changed sucessfully
db.auth('admin', 'password')

# check the user info
db.runCommand({usersInfo:  { user: "admin", db: "admin" },showPrivileges: true});

# install macos mongo client 
brew install mongosh
mongosh "mongodb://admin:password@ip:27017"

# 创建只读用户
db.createUser({user:'uername',pwd:'password', roles: [{ role: 'read', db: 'chatgpt' }] })