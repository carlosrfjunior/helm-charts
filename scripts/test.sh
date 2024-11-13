#!/bin/bash

helm dependency update ../microservice && helm template microservice-test ../microservice -f ../microservice/values.yaml  --debug
