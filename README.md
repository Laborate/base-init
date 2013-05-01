1. **Create SSH Keys And Add To Github**
```bash
cd ~/.ssh
ssh-keygen -t rsa -C "admin@laborate.io"
cat ~/.ssh/id_rsa.pub
```

2. **Install Git**
```bash
sudo apt-get -y install git
```

3. **Paste Installer Script**
```bash
cd ~/.ssh; ssh-keygen -t rsa -C "<username>@laborate.io"; clear; cat ~/.ssh/id_rsa.pub;
```
