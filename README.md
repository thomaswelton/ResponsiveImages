ResponsiveImages
================

A javascript framework written in coffeescript to load images "responsively" and responsibly.

### Introduction

This is yet another responsive images solution. It allows for different images to be displayed based on the browsers width.

Key features:
* Does not wait for window.onload or domready to start loading optimized images
* No dependencies
* Lightweight 
* Good browser support for your IEs 6+

### Installation

Drop responsiveImages.js into your head

```html
<script src="responsiveImages.js"></script>
```

### Usage

Lets say you currently have an image like this on your page

```html
<img src="image.jpg" alt="Some image" width=1200 height=1200>
```

It's likely that for users on mobile devices you're going to want to serve an alternate image.
Using responsiveImages.js this can achieved by making the following alterations to your existing markup

```html
<img src="/favicon.ico" alt="Some image" width=1200 height=1200
     data-src="image.jpg"
     style="visibility:hidden"
	 onload="responsiveImages.injectImage(this)" 
     data-src-320="image-320.jpg"
     data-src-640="image-640.jpg">
     
<noscript>
    <img src="image.jpg" alt="Some image" width=1200 height=1200>
</noscript>
```

The ``<img>`` tag was duplicated, one being wrapped in a ``noscript`` block to allow images to be loaded when javascript is disabled.

The duplicate ``<img>`` tag was edited to be used by responsiveIamges.js
Changes:
* The ``src`` attribute was changed to ``src="/favicon.ico"``
* Attribute ``data-src`` added whose value was the original image ``src``
* Added inline style `visibility:hidden`, removed when optimized
* onload event added to the image that calls the injectImage method of responsiveImages
* ``data-src-*`` attributes added to specify the image paths to be used for browsers of various widths. The integer specifies the largest width where the optimized values should be loaded for. For browsers 0px-320px wide ``data-src-320`` will be loaded, 321px-640px wide ``data-src-640`` will be used, browsers wider than 641px will get the ``data-src`` image

If the browser is resized images will be reoptimized loading larger or smaller images where required.

