#!/usr/bin/env bash

DIR=`pwd`
cd ${DIR}/test
bash run-project-tests.sh
# bash run-zeppelin-tests.sh
# bash run-all-tests.sh
cd ${DIR}
