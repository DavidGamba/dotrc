# kubectl change namespace
kcn() {
	[[ $# -eq 0 ]] && kubectl get namespaces && return 0
	kubectl config set-context --current --namespace "$1"
}
complete -F _kcn_completion kcn
_kcn_completion() {
	kubectl get ns -o=jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'
}

# kubectl use context
kuc() {
	[[ $# -eq 0 ]] && kubectl config get-contexts && return 0
	kubectl config use-context "$1"
}
complete -F _kuc_completion kuc
_kuc_completion() {
	kubectl config get-contexts -o name
}
