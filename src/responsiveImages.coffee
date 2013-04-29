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

		@className = 'responsiveImage'
		@attrPathId = "data-path-"
		@paths = {}
		@images = []

		addEvent window, 'resize', @onresize

	setPaths: (json) =>
		for key, values of json
			if @paths[key]?
				@paths[key] = @mergeSizes @paths[key], values
			else
				@paths[key] = values

	mergeSizes: (baseJson, newJson) ->
		merged = newJson
		for size, src of baseJson
			merged[size] = src if !merged[size]?

		return merged

	getOptimisedSrc: (img) =>
		src = img.getAttribute 'data-src'
		paths = @mergeSizes @paths[src], @getAttrPaths(img)

		for size, imgSrc of paths
			src = imgSrc if @clientWidth > size

		return src

	optimizeImage: (img) =>
		optimsisedSrc = @getOptimisedSrc img
		img.src = optimsisedSrc if img.src isnt optimsisedSrc

		return

	updateImages: () =>
		## Recalculate the browser width
		@clientWidth = document.documentElement.clientWidth

		## Loops over all .responsiveImage elements and optimizes them
		@optimizeImage img for img in @images
		
		return

	getAttrPaths: (img) =>
		src = img.getAttribute 'data-src'

		sizeData = {}
		for attribute in img.attributes when attribute.name.indexOf(@attrPathId) is 0
			size = attribute.name.substr @attrPathId.length
			path = attribute.value

			sizeData[size] = path

		return sizeData

	injectImage: (img) =>
		## Remove the on load function that triggered this function
		img.onload = null
		img.removeAttribute 'onload'
		img.className += ' ' + @className

		@images.push img

		## Optimize the image
		@optimizeImage img

	onresize: () =>
		if @timeout?
			clearTimeout @timeout

		@timeout = setTimeout @updateImages, 250

@responsiveImages = new responsiveImages()
