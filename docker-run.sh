#!/bin/ash

helm dependency update /apps/charts/micro-node-red
helm unittest /apps/charts/micro-node-red