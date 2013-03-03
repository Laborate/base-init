**Create SSH Keys And Add To Github**
```bash
cd ~/.ssh
ssh-keygen -t rsa -C "your_email@example.com"
cat ~/.ssh/id_rsa.pub
```

**Install Git**
```bash
sudo apt-get -y install git
```


**Paste Installer Script in ```www``` Folder**
```bash
git clone git@github.com:Laborate/base-init.git
sudo bash base-init/init/init.sh
sudo rm -r base-init
```
