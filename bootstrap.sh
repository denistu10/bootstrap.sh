#!/usr/bin/env bash

fail() {
    echo
    echo 'ой-ой. Ошибка выполнения команды. Выход'
    exit 1
}

exec_cmd_nofail() {
    echo "+ $1"
    bash -c "$1"
}

exec_cmd() {
    exec_cmd_nofail "$1" || fail
}

setup_python() {
    exec_cmd 'yum install -y epel-release'
    exec_cmd 'yum -y install python-pip git'
}

setup_ansible() {
    exec_cmd 'pip install -U pip'
    exec_cmd 'pip install -U ansible'
}

download_module() {
    cd /tmp/
    git clone https://github.com/denistu10/ansible-bootstrap.git
}

run_bootstrap() {
    cd /tmp/ansible-bootstrap
    exec_cmd 'ansible-playbook playbook.yml'
}

run() {
    setup_python
    setup_ansible
    download_module
    run_bootstrap
    rmn -rf /tmp/ansible-bootstrap
}

run