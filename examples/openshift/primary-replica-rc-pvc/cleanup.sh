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

oc delete dc p-r-rc-pvc-replica
oc delete pod p-r-rc-pvc-primary
oc delete pod p-r-rc-pvc-replica
oc delete pod -l name=p-r-rc-pvc-primary
$CCPROOT/examples/waitforterm.sh p-r-rc-pvc-primary oc
$CCPROOT/examples/waitforterm.sh p-r-rc-pvc-replica oc
oc delete service p-r-rc-pvc-primary
oc delete service p-r-rc-pvc-replica

sudo rm -rf $PV_PATH/p-r-rc-pvc*
