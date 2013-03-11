addEvent = (elem, type, eventHandle) ->
	return if !elem?

	if elem.addEventListener
		elem.addEventListener type, eventHandle, false
	else if elem.attachEvent
		elem.attachEvent "on#{type}", eventHandle
	else
		elem["on#{type}"] = eventHandle

class responsiveImages
	constructor: () ->
		@clientWidth = document.documentElement.clientWidth

		@paths = {}
		@images = []

		## Add resize event to optimize images
		addEvent window, 'resize', @onresize

	setPaths: (json) =>
		for key, values of json
			if @paths[key]?
				@paths[key] = @mergeSizes @paths[key], values
			else
				@paths[key] = values

		return

	getOptimisedSrc: (img) =>
		key = img.getAttribute 'data-id'
		paths = @mergeSizes @paths[key], @getAttrPaths(img)

		for size, imgSrc of paths
			return imgSrc if @clientWidth <= size
		
		return img.getAttribute 'data-src'

	mergeSizes: (baseJson, newJson) ->
		merged = newJson
		for size, src of baseJson
			merged[size] = src if !merged[size]?

		return merged

	optimizeImage: (img) =>
		optimsisedSrc = @getOptimisedSrc img
		img.src = optimsisedSrc if img.src isnt optimsisedSrc

		return

	updateImages: () =>
		## Recalculate the browser width
		@clientWidth = document.documentElement.clientWidth

		@optimizeImage img for img in @images
		
		return

	## Get optimized images paths form img elements from data attributes
	getAttrPaths: (img) =>
		src = img.getAttribute 'data-src'

		sizeData = {}
		for attribute in img.attributes when attribute.name.indexOf('data-src-') is 0
			size = attribute.name.substr "data-src-".length
			path = attribute.value

			sizeData[size] = path

		return sizeData

	injectImage: (img) =>
		## Remove the on error function that triggered this function
		img.onerror = null
		img.removeAttribute 'onerror'

		## Add this to the array of responsive images
		@images.push img

		## Optimize the image
		@optimizeImage img

		return

	onresize: () =>
		if @timeout?
			clearTimeout @timeout
		## Throttle the resize event to only fire 250ms after the last resize event
		@timeout = setTimeout @updateImages, 250

		return


## Expose this to the global name space
@responsiveImages = new responsiveImages()
