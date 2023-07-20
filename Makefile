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