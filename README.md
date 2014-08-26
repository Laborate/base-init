1. **Install Git on Server**

```bash
sudo apt-get -y install git
```

2. **Paste Installer Script on Server**
  
  - Development

      ```bash
      cd ~; git clone git@github.com:Laborate/base-init.git; sudo bash base-init/init.sh dev;
      ```
  - Production

      ```bash
      cd ~; git clone git@github.com:Laborate/base-init.git; sudo bash base-init/init.sh;
      ```
