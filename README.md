# Root Only

1. **Create Local SSH Keys And Add To Github**
```bash
cd ~/.ssh; ssh-keygen -t rsa -C "admin@laborate.io"; clear; cat ~/.ssh/id_rsa.pub;
```

2. **Add Local Keys To Server**
```bash
cat ~/.ssh/id_rsa.pub | ssh root@<server>.laborate.io "cat >> ~/.ssh/authorized_keys"
```

3. **Install Git on Server**
```bash
sudo apt-get -y install git
```

4. **Paste Installer Script on Server**
  - Development

      ```bash
      cd ~; git clone git@github.com:Laborate/base-init.git; sudo bash base-init/init.sh dev;
      ```
  - Production

      ```bash
      cd ~; git clone git@github.com:Laborate/base-init.git; sudo bash base-init/init.sh;
      ```

5. **Paste Post Install Script on Server**
```bash
sudo bash base-init/post.sh;
```
