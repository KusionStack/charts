#!/bin/bash
# check args
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <kubeconfig_key1=kubeconfig_path1> [kubeconfig_key2=kubeconfig_path2 ...]"
    exit 1
fi

# Process all kubeconfig key-path pairs
KUBECONFIG_ARGS=""
for arg in "$@"; do
    # Split key=path format
    IFS='=' read -r key path <<<"$arg"

    if [ -z "$key" ] || [ -z "$path" ]; then
        echo "Error: Invalid format. Use kubeconfig_key=kubeconfig_path"
        exit 1
    fi

    if [ ! -f "$path" ]; then
        echo "Error: Kubeconfig file not found: $path"
        exit 1
    fi

    # Detect operating system
    os_type=$(uname -s)

    # base64 encode
    # Choose base64 parameter according to the operating system
    if [[ "$os_type" == "Linux" ]]; then
        content=$(base64 -w 0 "$path")
    elif [[ "$os_type" == "Darwin" ]]; then
        content=$(base64 -b 0 -i "$path")
    else
        echo "Unsupported OS: $os_type"
        exit 1
    fi

    # Build helm --set argument
    KUBECONFIG_ARGS="${KUBECONFIG_ARGS} --set kubeconfig.kubeConfigs.${key}=${content}"
done

# install/upgrade helm chart
helm repo add kusionstack https://kusionstack.github.io/charts
helm repo update
helm upgrade -i kusion-release kusionstack/kusion ${KUBECONFIG_ARGS}
