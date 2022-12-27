### Configuração Kubernates
AWS CLI

precisa da AWS CLI instalado -> https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html
e do kubectl -> https://docs.bitnami.com/kubernetes/faq/get-started/install-kubectl nesse link da erro,
consegui aqui: https://kubernetes.io/docs/tasks/tools/install-kubectl-macos

aws --version
kubectl version

executar 
$ aws configure
ou
$ export AWS_DEFAULT_REGION="us-east-1"
$ export AWS_ACCESS_KEY_ID=xxx
$ export AWS_SECRET_ACCESS_KEY=xxx


Para assumir a config do kubectl
$ aws eks --region us-east-1 update-kubeconfig --name test



### Comandos Kubernates
log pod:
$ kubectl logs -n mobile -l app=mobile-app-gateway -f --tail=500

delete all pod:
$ kubectl delete --all pods -n mobile

$ kubectl get pods -n mobile
$ kubectl get namespace
$ kubectl logs --follow -n cards card-account-fspcx card-account
$ kubectl logs --follow -n nomenamespce nomedopod nomedocontainer
$ kubectl delete pods -n cards card-wt597
