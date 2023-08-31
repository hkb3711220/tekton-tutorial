* Create New Secret for pulling image
```bash
kubectl create secret docker-registry artifact-registry \
--docker-server=https://asia-northeast1-docker.pkg.dev \
--docker-email=chanhu-profile-site@civil-campaign-244100.iam.gserviceaccount.com \
--docker-username=_json_key \
--docker-password="$(cat ./private-key.json)"
```

* Update service account 

```bash
kubectl edit serviceaccount tekton-admin --namespace default
```
or Update Service Account Manifest Directly

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tekton-admin
secrets:
  - name: git-cred
  - name: docker-cred
imagePullSecrets:
  - name: artifact-registry

```
