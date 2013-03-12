(function() {
  var addEvent, responsiveImages,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  addEvent = function(elem, type, eventHandle) {
    if (!(elem != null)) {
      return;
    }
    if (elem.addEventListener) {
      return elem.addEventListener(type, eventHandle, false);
    } else if (elem.attachEvent) {
      return elem.attachEvent("on" + type, eventHandle);
    } else {
      return elem["on" + type] = eventHandle;
    }
  };

  responsiveImages = (function() {

    function responsiveImages() {
      this.onresize = __bind(this.onresize, this);

      this.injectImage = __bind(this.injectImage, this);

      this.getAttrPaths = __bind(this.getAttrPaths, this);

      this.updateImages = __bind(this.updateImages, this);

      this.optimizeImage = __bind(this.optimizeImage, this);

      this.getOptimisedSrc = __bind(this.getOptimisedSrc, this);

      this.setPaths = __bind(this.setPaths, this);
      this.clientWidth = document.documentElement.clientWidth;
      this.paths = {};
      this.images = [];
      addEvent(window, 'resize', this.onresize);
    }

    responsiveImages.prototype.setPaths = function(json) {
      var key, values;
      for (key in json) {
        values = json[key];
        if (this.paths[key] != null) {
          this.paths[key] = this.mergeSizes(this.paths[key], values);
        } else {
          this.paths[key] = values;
        }
      }
    };

    responsiveImages.prototype.getOptimisedSrc = function(img) {
      var imgSrc, key, paths, size;
      key = img.getAttribute('data-id');
      paths = this.mergeSizes(this.paths[key], this.getAttrPaths(img));
      for (size in paths) {
        imgSrc = paths[size];
        if (this.clientWidth <= size) {
          return imgSrc;
        }
      }
      return img.getAttribute('data-src');
    };

    responsiveImages.prototype.mergeSizes = function(baseJson, newJson) {
      var merged, size, src;
      merged = newJson;
      for (size in baseJson) {
        src = baseJson[size];
        if (!(merged[size] != null)) {
          merged[size] = src;
        }
      }
      return merged;
    };

    responsiveImages.prototype.optimizeImage = function(img) {
      var optimsisedSrc;
      optimsisedSrc = this.getOptimisedSrc(img);
      if (img.src !== optimsisedSrc) {
        img.src = optimsisedSrc;
      }
    };

    responsiveImages.prototype.updateImages = function() {
      var img, _i, _len, _ref;
      this.clientWidth = document.documentElement.clientWidth;
      _ref = this.images;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        img = _ref[_i];
        this.optimizeImage(img);
      }
    };

    responsiveImages.prototype.getAttrPaths = function(img) {
      var attribute, path, size, sizeData, src, _i, _len, _ref;
      src = img.getAttribute('data-src');
      sizeData = {};
      _ref = img.attributes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        attribute = _ref[_i];
        if (!(attribute.name.indexOf('data-src-') === 0)) {
          continue;
        }
        size = attribute.name.substr("data-src-".length);
        path = attribute.value;
        sizeData[size] = path;
      }
      return sizeData;
    };

    responsiveImages.prototype.injectImage = function(img) {
      img.onerror = null;
      img.removeAttribute('onerror');
      this.images.push(img);
      this.optimizeImage(img);
    };

    responsiveImages.prototype.onresize = function() {
      if (this.timeout != null) {
        clearTimeout(this.timeout);
      }
      this.timeout = setTimeout(this.updateImages, 250);
    };

    return responsiveImages;

  })();

  this.responsiveImages = new responsiveImages();

}).call(this);
