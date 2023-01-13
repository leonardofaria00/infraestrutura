### generating a new SSH key
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

### start the ssh-agent in the background
$ eval "$(ssh-agent -s)"

### add ssh key to ssh-agent
$ ssh-add ~/.ssh/id_rsa

### testing your SSH connection
$ ssh -T git@github.com || ssh -T git@ssh.dev.azure.com

Success if output: remote: Shell access is not supported.

## Add your public key in repository Git
$ cat ~/.ssh/id_rsa.pub

## Change HTTPS URLs to SSH Connection
$ git remote -v

$ git remote set-url origin ssh.path
