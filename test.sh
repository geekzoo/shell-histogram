#!/bin/bash
./sormat.sh <(for i in {000000..999999}; do echo "${i} $(( $RANDOM % 240 ))"; done)