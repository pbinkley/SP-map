NOTES

- the only IIIF version of the Amerbach edition that I can find is https://iiif.biblissima.fr/collections/manifest/e4792067aa00794eb5e388411494b87963a5c319 
- manifest: https://permalinkbnd.bnportugal.gov.pt/iiif/69702/manifest

- switch to the Basel copy: https://www.e-rara.ch/bau_1/doi/10.3931/e-rara-18427 - see terms of use: Public Domain Mark, but they ask for credit and notification
- manifest: https://www.e-rara.ch/i3f/v20/5788453/manifest


## SimpleAnnotationServer

- installed on hoffnung: ~/sas
- start with ```java -jar dependency/jetty-runner.jar --port 8888 simpleAnnotationStore.war```
- access at http://localhost:8888/index.html


Mirador actions: https://github.com/ProjectMirador/mirador/blob/master/src/state/actions/action-types.js

- includes:   SELECT_ANNOTATION: 'mirador/SELECT_ANNOTATION',
- https://github.com/ProjectMirador/mirador/blob/5ca33205bf9bac636ba5ef0faf820f58c0d9751d/src/state/actions/annotation.js has:
```
	/**
	 * selectAnnotation - action creator
	 *
	 * @param  {String} windowId
	 * @param  {String} targetId
	 * @param  {String} annotationId
	 * @memberof ActionCreators
	 */
	export function selectAnnotation(windowId, annotationId) {
	  return {
	    annotationId,
	    type: ActionTypes.SELECT_ANNOTATION,
	    windowId,
	  };
	}
```
- this looks like the way to do it: https://docs.google.com/document/d/1_LPOcwMOM051qzhqMixqLLKXZ5SH9Vjd3_UA-tZniek/edit#heading=h.egm5cqss696p

## Processing IIIF

1. run ```fetch.sh``` for each chapter that has annotations. It downloads annotations and runs ```prepare_annotations.rb```, which prepares chapter/canvas-level annotations lists in ```SP-map/annotations```
2. run ```prepare_manifests.rb```. It reads the chapter list and generates chapter-level manifests in ```SP-map/manifests/``` and a IIIF collection in ```SP-map/collection.json```

## Processing Index

1. run ```preprocess_index.rb```. It reads the old Nota Bene index files from ```Index``` and generates json files names ```index-7.json1``` etc.
2. run ```generate_index.rb```. It reads the index json files and outputs full md files for each index type. This is where the md links are added to reference.
3. run ```chop_index.rb```. This reads the full md files and outputs the alphabetical sections (A, B, C, etc.) as markdown to ```SP-map/sections```
