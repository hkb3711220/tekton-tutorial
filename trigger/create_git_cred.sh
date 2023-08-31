#! /bin/bash

Host="github.com"                # Gitプラットフォーム
User="git"
IdentityFile="~/.ssh/id_rsa"     # Gitプラットフォームに対するユーザーのsshプライベートキー
SecretFile="./secret-template.yaml"
id_rsa=$(eval cat ${IdentityFile}| base64)
config=$(cat << __EOC__ | base64
Host ${Host}
  User ${User}
  IdentityFile /home/git/.ssh/id_rsa
__EOC__
)
known_hosts=$(ssh-keyscan ${Host} 2>/dev/null| base64 )
cat ${SecretFile} | sed -e "s/__ID_RSA__/${id_rsa}/g" | sed -e "s/__CONFIG__/${config}/g" | sed -e "s/__KNOWN_HOSTS__/${known_hosts}/g" > ./secret.yaml
kubectl apply -f ./secret.yaml
rm -f ./secret.yaml

