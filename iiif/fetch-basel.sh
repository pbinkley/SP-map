#!/bin/bash
# arg: chapter code e.g. A.2
mkdir -p annotations/basel
python3 ./downloadAnnotationListsByCanvas.py https://www.e-rara.ch/i3f/v20/5788453/manifest http://localhost:8888 annotations/basel
#./prepare_annotations.rb $1
