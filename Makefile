C_NAME?=j1
S_NAME?=s1
P_NAME?=p1

.PHONY: install
install: ensure.kubeconfig
	helm install $(C_NAME) cool-configmap
	helm install $(S_NAME) cool-secret
	helm install $(P_NAME) cool-infinity

.PHONY: uninstall
uninstall: ensure.kubeconfig
	helm uninstall $(C_NAME) $(S_NAME) $(P_NAME)

.PHONY: ensure.kubeconfig
ensure.kubeconfig:
	# Expect KUBECONFIG to be set
	printenv KUBECONFIG

.PHONY: packagecharts
packagecharts:
	mkdir helm-charts || true
	helm package --destination ./helm-charts/ cool-configmap 
	helm package --destination ./helm-charts/ cool-secret 
	helm package --destination ./helm-charts/ cool-infinity 

.PHONY: index.create
index.create:
	helm repo index .

.PHONY: index.addlocal
index.addlocal:
	# make sure to run ./scripts/runindex.sh
	helm repo add local http://localhost:8000


.PHONY: index.removelocal
index.removelocal:
	helm repo remove local

