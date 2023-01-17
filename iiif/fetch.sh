#!/bin/bash
# arg: chapter code e.g. A.2
mkdir -p annotations/$1
python3 ./downloadAnnotationListsByCanvas.py https://pbinkley.github.io/SP-map/manifests/$1.json http://localhost:8888 annotations/$1
./prepare_annotations.rb $1