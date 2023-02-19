#!/bin/bash

OS=$(uname)
Color_Off='\033[0m'
Color_Green='\033[0;32m'
Color_Red='\033[0;31m'


echo_success() {
  echo -e "${Color_Green}${1}${Color_Off}"
}

echo_error() {
  echo -e "${Color_Red}${1}${Color_Off}"
}


# Step 0: Clean
# ================

echo "Bootstraping project..."

echo "Remove node packages..."
rm -rf node_modules


# Step 1: Node
# ================

if [ ! -z "${NVM_DIR}" ]; then
  echo_success "Found nvm using NVM_DIR=${NVM_DIR}..."
  source ${NVM_DIR}/nvm.sh
  nvm install
else
  echo_error "nvm not found. Make sure you have installed node $(cat .nvmrc)"
fi

if command -v node > /dev/null && command -v npm > /dev/null; then
  echo_success "Found node $(node -v) / npm $(npm -v)"
else
  echo_error "node (npm) not found."
  exit 1
fi

echo "Install node packages..."
npm install

echo "Setup husky..."
npx husky install


# Step 2: Extra work
# ================

echo "Finalizing..."
chmod +x ./.husky/pre-commit
chmod +x ./.husky/_/husky.sh
find ./@scripts/ -type f -iname "*.sh" -exec chmod +x {} \;


# Step 3: Complete
# ================

echo "Bootstrap completed!"