# Comand GIT

Deletar branch do repositório remoto
```bash
git push origin --delete branchName
```

Deletar branch do repositório local
```bash
git branch -D branchName
```

For every branch that is up to date or successfully pushed, add upstream (tracking) reference, used by argument-less git-pull[1] and other commands.
```bash
git push --set-upstream origin branchName
```
