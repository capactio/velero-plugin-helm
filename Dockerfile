# Copyright 2017, 2019, 2020 the Velero contributors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.16-buster AS build
WORKDIR /go/src/github.com/lukaszo/velero-plugin-helm
COPY . .
RUN CGO_ENABLED=0 go build -o /go/bin/velero-plugin-helm .


FROM ubuntu:bionic
RUN mkdir /plugins
COPY --from=build /go/bin/velero-plugin-helm /plugins/
USER nobody:nogroup
ENTRYPOINT ["/bin/bash", "-c", "cp /plugins/* /target/."]
