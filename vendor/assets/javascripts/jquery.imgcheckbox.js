/*
 * imgCheckbox
 *
 * Version: 0.3.5
 * License: GPLv2
 * Author:  Masayuki Uehara
 * Last Modified: 2015.07.05
 *
 */
(function($) {
  var util = {
    a2o: function (array) {
      var result = {};
      for (var i = 0, len = array.length; i < len; i++) {
        var pair = array[i];
        result[pair[0]] = pair[1];
      }
      return result;
    }
  },
  cssClass = {
    checked: 'imgChked',
    checkbox: 'imgCheckbox'
  };

	var imgCheckboxClass = function(element, options, id) {
		var $wrapperElement,
        $finalStyles = {},
        grayscaleStyles = {
          "span.imgCheckbox img": {
            "transform": "scale(1)",
            "-webkit-transform": "scale(1)",
            "filter": "none",
            "-webkit-filter": "grayscale(0)"
          },
          "span.imgCheckbox.imgChked img": {
            // "filter": "gray", //TODO - this line probably will not work but is necessary for IE
            "filter": "grayscale(1)",
            "-webkit-filter": "grayscale(1)"
          }
        },
        scaleStyles = {
          "span.imgCheckbox img": {
            "transform": "scale(1)",
            "-webkit-transform": "scale(1)"
          },
          "span.imgCheckbox.imgChked img": {
            "transform": "scale(0.8)",
            "-webkit-transform": "scale(0.8)"
          }
        },
        scaleCheckMarkStyles = {
          "span.imgCheckbox::before": {
            "transform": "scale(0)",
            "-webkit-transform": "scale(0)"
          },
          "span.imgCheckbox.imgChked::before": {
            "transform": "scale(1)",
            "-webkit-transform": "scale(1)"
          }
        },
        fadeCheckMarkStyles = {
          "span.imgCheckbox::before": {
            "opacity": "0"
          },
          "span.imgCheckbox.imgChked::before": {
            "opacity": "1"
          }
        };

		/* *** STYLESHEET STUFF *** */
		// shove in the custom check mark
		if (options.checkMarkImage != false) {
      $.extend(true, $finalStyles, {"span.imgCheckbox::before": {"background-image": "url('" + options.checkMarkImage + "')"}});
    }
		// give the checkmark dimensions
		var chkDimensions = options.checkMarkSize.split(" ");
		$.extend(true, $finalStyles, { "span.imgCheckbox::before": {
			"width": chkDimensions[0],
			"height": chkDimensions[chkDimensions.length - 1]
		}});
		// fixed image sizes
		if (options.fixedImageSize) {
			var imgDimensions = options.fixedImageSize.split(" ");
			$.extend(true, $finalStyles,{ "span.imgCheckbox img": {
				"width": imgDimensions[0],
				"height": imgDimensions[imgDimensions.length - 1]
			}});
		}
		// extend with grayscale for the selected images (if set to true)
		if (options.graySelected) {
      $.extend(true, $finalStyles, grayscaleStyles);
    }
		// extend with scale styles (if set to true)
		if (options.scaleSelected) {
      $.extend(true, $finalStyles, scaleStyles);
    }
		// extend with scale styles (if set to true)
		if (options.scaleCheckMark) {
      $.extend(true, $finalStyles, scaleCheckMarkStyles);
    }
		// extend with scale styles (if set to true)
		if (options.fadeCheckMark) {
      $.extend(true, $finalStyles, fadeCheckMarkStyles);
    }

		$finalStyles = $.extend(true, {}, defaultStyles, $finalStyles, options.styles);

		// Now that we've built up our styles, inject them
		injectStylesheet($finalStyles, id);

		/* *** DOM STUFF *** */
		element.wrap(
      "<span class='" +
      [
        "imgCheckbox" + id,
        (options.radio && options.radio !== true ? options.radio : "imgCheckboxWrapper")
      ].join(' ') +
      "'>"
    );

		// preselect elements
		$wrapperElement = element.parent();
		if (options.preselect.length > 0) {
			$wrapperElement.each(function(index){
				if (options.preselect.indexOf(index) >= 0) {
          $(this).addClass(cssClass.checked);
        }
			})
		}

		// set up click handler
		$wrapperElement.click(function() {
      var $this = $(this),
          hasClass = $this.hasClass(cssClass.checked);

      if (options.radio) {
        $(options.radio === true ? ".imgCheckboxWrapper" : options.radio).each(function(){
          var $elm = $(this);
          $elm.removeClass(cssClass.checked);
          if (options.addToForm) {
            $( "." + $elm.data("hiddenElementId") ).prop("checked", false);
          }
        });
      }

      if (hasClass) {
        $this.removeClass(cssClass.checked);
      } else {
        $this.addClass(cssClass.checked);
      }

      if (options.addToForm) {
        $( "." + $this.data("hiddenElementId") ).prop("checked", !hasClass);
      }
    });

		/* *** INJECT INTO FORM *** */
		forminjection: if (options.addToForm != false) {
			if (!(options.addToForm instanceof jQuery)) {
				options.addToForm = $(element).closest("form");
				if (options.addToForm.length == 0) {
					options.addToForm = false;
					break forminjection;
				}
			}
			$(element).each(function(index){
				var hiddenElementId = "hEI" + id + "-" + index;
				$(this).parent().data('hiddenElementId', hiddenElementId);
				var imgName = $(this).attr("name");
				imgName = (typeof imgName != "undefined") ? imgName : $(this).attr("src").match(/\/(.*)\.[\w]+$/)[1];
        if (options.radio) {
          $('<input />').attr('type', 'radio')
            .attr('name', imgName)
            .attr('value', $(this).data('value') ? $(this).data('value') : index)
            .addClass(hiddenElementId)
            .css("display", "none")
            .prop("checked", $(this).parent().hasClass(cssClass.checked))
            .appendTo(options.addToForm);
        } else {
          $('<input />').attr('type', 'checkbox')
            .attr('name', imgName)
            .addClass(hiddenElementId)
            .css("display", "none")
            .prop("checked", $(this).parent().hasClass(cssClass.checked))
            .appendTo(options.addToForm);
        }
			});
		}

		return this;
	};

	/* CSS Injection */
	function injectStylesheet(stylesObject, id){
		// Create a blank style
		var style = document.createElement("style");
		// WebKit hack
		style.appendChild(document.createTextNode(""));
		// Add the <style> element to the page
		document.head.appendChild(style);

		var stylesheet = document.styleSheets[document.styleSheets.length - 1];

		for (var selector in stylesObject){
			if (stylesObject.hasOwnProperty(selector)) {
				compatInsertRule(stylesheet, selector, buildRules(stylesObject[selector]), id);
			}
		}
	}

	function buildRules(ruleObject) {
		var ruleSet = "";
		for (var property in ruleObject){
			if (ruleObject.hasOwnProperty(property)) {
				 ruleSet += property + ":" + ruleObject[property] + ";";
			}
		}
		return ruleSet;
	}

	function compatInsertRule(stylesheet, selector, cssText, id) {
		var modifiedSelector = selector.replace(".imgCheckbox", ".imgCheckbox" + id);
		// IE8 uses "addRule", everyone else uses "insertRule"
		if (stylesheet.insertRule) {
			stylesheet.insertRule(modifiedSelector + '{' + cssText + '}', 0);
		} else {
			stylesheet.addRule(modifiedSelector, cssText, 0);
		}
	}


	/* Init */
	$.fn.imgCheckbox = function(options){
		if ($(this).data("imgCheckboxId")) {
      return $.fn.imgCheckbox.instances[$(this).data("imgCheckboxId") - 1];
    } else {
			var $that = new imgCheckboxClass($(this), $.extend(true, {}, $.fn.imgCheckbox.defaults, options), $.fn.imgCheckbox.instances.length);
			$(this).data("imgCheckboxId", $.fn.imgCheckbox.instances.push($that));
			return $that;
		}
	};
	$.fn.imgCheckbox.instances = [];
	$.fn.imgCheckbox.defaults = {
		"checkMarkImage": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI2NCIgaGVpZ2h0PSI2NCI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMCAtMzQ2LjM4NCkiPjxwYXRoIGZpbGw9IiMxZWM4MWUiIGZpbGwtb3BhY2l0eT0iLjgiIGQ9Ik0zMiAzNDYuNGEzMiAzMiAwIDAgMC0zMiAzMiAzMiAzMiAwIDAgMCAzMiAzMiAzMiAzMiAwIDAgMCAzMi0zMiAzMiAzMiAwIDAgMC0zMi0zMnptMjEuMyAxMC4zbC0yNC41IDQxTDkuNSAzNzVsMTcuNyA5LjYgMjYtMjh6Ii8+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTkuNSAzNzUuMmwxOS4zIDIyLjQgMjQuNS00MS0yNiAyOC4yeiIvPjwvZz48L3N2Zz4=",
		"graySelected": true,
		"scaleSelected": true,
		"fixedImageSize": false,
		"checkMarkSize": "30px",
		"scaleCheckMark": true,
		"fadeCheckMark": false,
		"addToForm": true,
    "radio": false,
		"preselect": []
	};
	var defaultStyles = {
		"span.imgCheckbox img": {
			"display": "block",
			"margin": "0",
			"padding": "0",
			"transition-duration": "300ms"
		},
		"span.imgCheckbox.imgChked img": {
		},
		"span.imgCheckbox": {
			"user-select": "none",
			"padding": "0",
			"margin": "5px",
			"display": "inline-block",
			"border": "1px solid transparent",
			"transition-duration": "300ms"
		},
		"span.imgCheckbox.imgChked": {
			"border-color": "#ccc"
		},
		"span.imgCheckbox::before": {
			"display": "block",
			"background-size": "100% 100%",
			"content": "''",
			"color": "white",
			"font-weight": "bold",
			"border-radius": "50%",
			"position": "absolute",
			"margin": "0.5%",
			"z-index": "1",
			"text-align": "center",
			"transition-duration": "300ms"
		},
		"span.imgCheckbox.imgChked::before": {
		}
	};

})( jQuery );
