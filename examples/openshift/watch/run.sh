#!/bin/bash
# Copyright 2018 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/cleanup.sh

# Create 'watch-hooks-configmap'.
oc create configmap watch-hooks-configmap \
	--from-file=./hooks/watch-pre-hook \
	--from-file=./hooks/watch-post-hook

oc create -f $DIR/watch-sa.json
oc policy add-role-to-group edit system:serviceaccounts -n $CCP_NAMESPACE
oc process -f $DIR/watch.json \
	-p CCP_NAMESPACE=$CCP_NAMESPACE \
	-p CCP_IMAGE_PREFIX=$CCP_IMAGE_PREFIX \
	-p CCP_IMAGE_TAG=$CCP_IMAGE_TAG | oc create -f -
