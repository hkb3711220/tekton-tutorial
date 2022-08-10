#! /bin/bash

Host="github.com"                # Gitプラットフォーム
User="git"
IdentityFile="~/.ssh/id_rsa"     # Gitプラットフォームに対するユーザーのsshプライベートキー
echo id_rsa: $(eval cat ${IdentityFile}| base64)
echo config: $(cat << __EOC__ | base64
Host ${Host}
  User ${User}
  IdentityFile /tekton/home/.ssh/id_rsa
__EOC__
)
echo known_hosts: $(ssh-keyscan ${Host} 2>/dev/null| base64 )
