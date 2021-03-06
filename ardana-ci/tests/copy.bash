#!/bin/bash
#
# (c) Copyright 2016 Hewlett Packard Enterprise Development LP
# (c) Copyright 2017 SUSE LLC
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

# $1 playbook name
# $2 can be limit or extra var
# $3 will be extra var when $2 is set
cp ~/ardana-ci-tests/$1 ~/scratch/ansible/next/ardana/ansible
if [ -n "$3" ]
then
  ansible-playbook -i hosts/verb_hosts $1 $2 -e $3
  status=$?
else
  if [ -n "$2" ];
  then
    if [[ $2 == *"limit"* ]]
    then
      ansible-playbook -i hosts/verb_hosts $1 $2
      status=$?
    else
      ansible-playbook -i hosts/verb_hosts $1 -e $2
      status=$?
    fi
  else
    ansible-playbook -i hosts/verb_hosts $1
    status=$?
  fi
fi
rm ~/scratch/ansible/next/ardana/ansible/$1
exit $status
