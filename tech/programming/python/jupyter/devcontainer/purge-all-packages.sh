set -e

pip freeze | xargs pip uninstall -y
