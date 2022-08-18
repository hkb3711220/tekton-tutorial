#! /bin/bash

Host="github.com"                # Gitプラットフォーム
User="git"
IdentityFile="~/.ssh/id_rsa"     # Gitプラットフォームに対するユーザーのsshプライベートキー
DockerConfig="./config.json"
CI_REGISTRY="asia-northeast1-docker.pkg.dev"
CI_REGISTRY_USER="oauth2accesstoken"
CI_REGISTRY_PASSWORD=$(gcloud auth print-access-token)
echo id_rsa: $(eval cat ${IdentityFile}| base64)
echo config: $(cat << __EOC__ | base64
Host ${Host}
  User ${User}
  IdentityFile /tekton/home/.ssh/id_rsa
__EOC__
)
echo known_hosts: $(ssh-keyscan ${Host} 2>/dev/null| base64 )

echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(printf "%s:%s" "${CI_REGISTRY_USER}" "${CI_REGISTRY_PASSWORD}" | base64 )\"}}}" > ./config.json 
echo config.json: $(cat ./config.json | base64)
