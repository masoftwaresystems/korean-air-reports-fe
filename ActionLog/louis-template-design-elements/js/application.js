$(document).ready(function() {
$("select").change(function(){
           if($(this).val() != null){
               $(this).css('font-weight', 'bold');
               console.log('hello');
           }else{
            $(this).css('font-weight', 'normal');   
           }
        });


    // Swap Values of Inputs (use .replaceValue)
        $(function() {
        	swapValues = [];
        		$(".replaceValue").each(function(i){
        			swapValues[i] = $(this).val();
        			$(this).focus(function(){
        				if ($(this).val() == swapValues[i]) {
        					$(this).val("");
        				}
        			}).blur(function(){
        				if ($.trim($(this).val()) == "") {
        					$(this).val(swapValues[i]);
        			}
        		});
        	});
        });

    // Main Slideshow - Using jQuery Cycle Plugin (http://jquery.malsup.com/cycle/)
        $('#mainImageSlider').cycle({
    		fx: 'fade',
    		pause: 1,
    		pager:  '#mainSlideNav',
    		cleartypeNoBg: true

    	});
    	// Main Navigation Slider
    	$('div.column div.slides.todo').cycle({
    		fx: 'fade',
    		pause: 1,
    		pager:  'div.dropdown.todo .slideNavBtns.todo',
    		cleartypeNoBg: true
    	});
    	$('div.column div.slides.stay').cycle({
    		fx: 'fade',
    		pause: 1,
    		pager:  'div.dropdown.stay .slideNavBtns.stay',
    		cleartypeNoBg: true
    	});
    	$('div.column div.slides.dine').cycle({
    		fx: 'fade',
    		pause: 1,
    		pager:  'div.dropdown.dine .slideNavBtns.dine',
    		cleartypeNoBg: true
    	});
    	$('div.column div.slides.nightlife').cycle({
    		fx: 'fade',
    		pause: 1,
    		pager:  'div.dropdown.nightlife .slideNavBtns.nightlife',
    		cleartypeNoBg: true
    	});
    	$('div.column div.slides.shop').cycle({
    		fx: 'fade',
    		pause: 1,
    		pager:  'div.dropdown.shop .slideNavBtns.shop',
    		cleartypeNoBg: true
    	});
    	// Feature Slider
        $('div.featureSlider').cycle({
            fx: 'scrollHorz',
            pause: 1,
            timeout: 0,
            speed: 5000,
            pager:  '#featureSliderNav',
            next: '.featureSliderContainer a.next',
            prev: '.featureSliderContainer a.prev'
        });

    // Uniform - Uniform Forms with jQuery (http://pixelmatrixdesign.com/uniform/)
        if($.support.opacity) {
            $("select, input[type=checkbox], input[type=radio], input[type=file], a.button, button").uniform();
        }

	// Header Booking Widget Accordion - Using jQuery UI (http://jqueryui.com/)
    	$( "#bookWidget div.accordion" ).accordion({
    	    autoHeight: false,
    	    collapsible: true
    	});

    	$.datepicker.setDefaults({
    	})

	// Header Booking Widget Datepickers - Using jQuery UI (http://jqueryui.com/)
	    $( "#bookHotelCheckIn" ).datepicker();
    	$( "#bookHotelCheckOut" ).datepicker();
    	$( "#findEventStartDate" ).datepicker({  
			minDate: 0, 
			onSelect: function(dateText, inst) {
				$( "#findEventEndDate" ).datepicker({  minDate: 0 });
				//$( "#findEventEndDate" ).datepicker( "option", "disabled", false );
				//$( "#findEventEndDate" ).datepicker( "option", "minDate", -2 );
 			}
		});
    	//$( "#findEventEndDate" ).datepicker({  minDate: 0, disabled: true });
    	$( "#eventDate" ).datepicker({
    	    beforeShow : function(node, instance) {
    	        instance.dpDiv.appendTo($(node).parents('.dropdown').eq(0));
    	        var offset = $(node).offset();
    	        setTimeout(function() { instance.dpDiv.offset({top: offset.top - instance.dpDiv.outerHeight(), left: offset.left - 20}) }, 10);

    	    },
    	    onClose : function(text, instance) {
    	        setTimeout(function() { instance.dpDiv.appendTo($('body')); }, 150);
    	    }
    	});

    // Events Calendar Browser
        //var dates = ['12/30/2010', '01/11/2011'];

        $('#eventsCalendarBrowse').datepicker({
           numberOfMonths: 2,
           dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
           showOtherMonths: true,
           selectOtherMonths: true,
           beforeShowDay: highlightDays,
           onChangeMonthYear: function() { setTimeout(function() { applyEventPopup(); }, 10); }
       });

        function highlightDays(date) {
            for (var i = 0; i < events.length; i++) {
					var event = events[i];
					if(!event) continue;
            	    var eventDate = events[i].date;
                    var currentDate = new Date(eventDate);
                    if (currentDate.toString() == date.toString()) {
                        return [true, 'highlight', $.datepicker.formatDate("m/dd/yy", currentDate)];
                    }
            }
            return [true, ''];
        }

        var wait = false;

        var applyEventPopup = function() {


            $('#eventsCalendarBrowse td.highlight a').bind('click', function(e) {
                var foundEvents = [];
                var node = $(this).parent();

                var currentDate = new Date(node.attr('title'));
                var dateStr = $.datepicker.formatDate('mm/dd/yy', currentDate);
				window.location = "/meeting-planners/?result=yes&startdate="+dateStr+"&button=Search&paramContentType=Convention+Event&form_template=Module-Events+Calendar&form_search=search&enddate="+dateStr+"&oneday=y&c=y";
				/*
                $.each(events, function(i, ievent) {
                    if(ievent && ievent.date == dateStr)
                    {
                        foundEvents.push(ievent);
                    }
                })

                if(foundEvents.length == 0)
                    return;

                var popup = $('#eventCalHover');

                popup.empty();

                var closeBtn = $('<a />').text('close').addClass('closeBtn').appendTo(popup);

                var date = $('<h3 />').text($.datepicker.formatDate('MM d, yy', currentDate)).addClass('date').appendTo(popup);

                var eventList = $('<ul />').addClass('events').appendTo(popup);
				var eventDate = "";
                $.each(foundEvents, function(i, foundEvent) {
					 eventDate = foundEvent.moreURL;
                    if(foundEvent.url.length > 0)
                        var title = $('<li />').append(foundEvent.org+ ' - ').append($('<a />').attr('href', foundEvent.url).text(foundEvent.title)).addClass('title').appendTo(eventList);
                    else
                        var title = $('<li />').append(foundEvent.org+ ' - ').text(foundEvent.title).addClass('title').appendTo(eventList);
                })

//                var more = $('<a />').attr('href', eventDate).text('› more').addClass('moreEvents').appendTo(popup);

                var offset = $(node).find('a').offset();

                popup.css({top: offset.top, left: offset.left});

                $(node).addClass('popped');
                popup.fadeIn(140);

                $(document.body).one('click', function(e) {
                    $('#eventCalHover').fadeOut(140, function(e) {
                        node.removeClass('popped');
                    });
                })

                $('a.closeBtn').click(function(e){
                    $(this).parent().fadeOut(140, function(e) {
                        node.removeClass('popped');
                    });
                })

                e.stopPropagation();
                return false;*/
            });
        }

        applyEventPopup();
        setInterval(function() { $('#eventsCalendarBrowse td.highlight a').unbind('click'); applyEventPopup(); }, 200);

        $('#eventCalHover').click(function(e) {
            e.stopPropagation();
        })
    // Expore San Francisco Side Tabs - Using jQuery UI (http://jqueryui.com/)
        $( "#exploreSanfran_tabs" ).tabs({ fx: { opacity: 'toggle' } });
        $( "#socialTabs" ).tabs(/*{ fx: { opacity: 'toggle' }*/);

    // Detail/Article Showcase Tabs
		var tabsInited = false;
        $( "#articleTabShowcaseTabs" ).tabs({
			select: function(){
				if(!tabsInited){
					var iframe = jQuery("iframe[name=googleMap]")[0];
					iframe.src = iframe.src;
					tabsInited = true;
				}
			}
		});

    // Detail/Article Slider
        $('.articlePhotos').cycle({
    		fx: 'fade',
    		pause: 1,
    		pager:  '.articlePhotosNav',
    		cleartypeNoBg: true,
    		timeout: 0
    	});

    // Features Accordion
        $( "#featuresAccordion" ).accordion({
    	    autoHeight: false,
    	    collapsible: true
    	});

    // Main Navigation Dropdowns (http://www.sohtanaka.com/web-design/mega-drop-downs-w-css-jquery/)
        function megaHoverOver(){
    		$(this).find(".dropdownWrap").stop().fadeTo('fast', 1).show();

    		//Calculate width of all ul's
    		(function($) {
    			jQuery.fn.calcSubWidth = function() {
    				rowWidth = 0;
    				//Calculate row
    				$(this).find("ul").each(function() {
    					rowWidth += $(this).width();
    				});
    			};
    		})(jQuery);

    		if ( $(this).find(".row").length > 0 ) { //If row exists...
    			var biggestRow = 0;
    			//Calculate each row
    			$(this).find(".row").each(function() {
    				$(this).calcSubWidth();
    				//Find biggest row
    				if(rowWidth > biggestRow) {
    					biggestRow = rowWidth;
    				}
    			});
    			//Set width
    			$(this).find(".dropdownWrap").css({'width' :biggestRow});
    			$(this).find(".row:last").css({'margin':'0'});

    		} else { //If row does not exist...

    			$(this).calcSubWidth();
    			//Set Width
    			$(this).find(".sub").css({'width' : rowWidth});

    		}
    	}

    	$('#mainNavigation').bind('mouseenter', function(e) {
			$('#header #bookWidget').fadeOut();
			$('#imageRotation ul.sideNav').fadeOut();
			$('#mainImageSlider').cycle('pause');
			$('div.slideContent').fadeOut(function(e) {
			    $(this).css('display', "none");
			});
    	})

    	$('#mainNavigation').bind('mouseleave', function(e) {
    	  $('div.slideContent').delay(200).fadeIn();
    	  $('#bookWidget').delay(200).fadeIn();
    	  $('#imageRotation ul.sideNav').delay(200).fadeIn();
    	  $('#mainImageSlider').cycle('resume');
    	})

    	function megaHoverOut(){
    	  $(this).find(".dropdownWrap").stop().fadeTo('fast', 0, function() {
    		  $(this).hide();
    	  });
    	}

    	var config = {
    		 sensitivity: 2, // number = sensitivity threshold (must be 1 or higher)
    		 interval: 50, // number = milliseconds for onMouseOver polling interval
    		 over: megaHoverOver, // function = onMouseOver callback (REQUIRED)
    		 timeout: 100, // number = milliseconds delay before onMouseOut
    		 out: megaHoverOut // function = onMouseOut callback (REQUIRED)
    	};

    	$("ul#mainNavigation > li .dropdownWrap").css({'opacity':'0'});
    	$("ul#mainNavigation > li").hoverIntent(config);

    // Tweet! (http://tweet.seaofclouds.com/)
    $(".tweet").tweet({
        join_text: "auto",
        username: "onlyinsf",
        avatar_size: 36,
        count: 3,
        auto_join_text_default: "we said,",
        auto_join_text_ed: "we",
        auto_join_text_ing: "we were",
        auto_join_text_reply: "we replied",
        auto_join_text_url: "we were checking out",
        loading_text: "Loading @onlyinsf Tweets..."
      });

    // YouTube Playlist Plugin
    $("ul.demo1").ytplaylist({autoPlay: false, playerHeight: 330, playerWidth: 440});

    // Various Column CSS Fixes
    $('div.findAnEvent div.form > div:odd').css('marginRight', 0);
    $('div.column:last').css('marginRight', 0);
    $('div.column div.day:odd').css('marginRight', 0);
    $('div.formSet .formItem:odd').css('marginRight', 0);
    $('#weekSummary div.day:last').addClass('lastDay');
    $('#partners li:last').css('marginRight', 0);
    $('.slideSet div.slide:nth-child(3n+3)').css({'marginRight': 0 });
    $('div.reviewSummaries div.summary:nth-child(3n+3)').css('marginRight', 0);
    $('div.multipleColFeatures div.featureItem').each(function(i, node) { if(i % 3 == 2) { $(node).css('marginRight', 0) } } );
    $('div.moreLinksThreeCol div.col:nth-child(3n+3)').css('marginRight', 0);

    // SVG Neighborhood Map (DEAD)
    $('#neighborhoodMap').svg({onLoad: function(svg) {
        svg.load('/sf_neighborhoods2.svg', {
    		addTo: true,
            changeSize: true,
    		onLoad: function(e) {
    			$('#neighborhoodMap path, #neighborhoodMap polygon').click(function(e) {
                    $('.infoPane').hide();
    				var node = $(this);
    				var target = node.attr('rel');
    				$(target).show();
    				active = target;
                    $('#neighborhoodMap path:not(*[rel=' + target + '])').animate({opacity: 0});
                    $('#neighborhoodMap polygon:not(*[rel=' + target + '])').animate({opacity: 0});
    			}).hover(function(e) {
                    if($(this).attr('rel') == active)
                        return false;

    				$(this).animate({opacity: 1});
    			}, function(e) {
                    if($(this).attr('rel') == active)
                        return false;

    				$(this).animate({opacity: 0});
    			})
    		}
    	});
    }});

    $('#neighborhoods ul.mapNav li a').click(function(e) {
        $('.infoPane').hide();
        var node = $(this);
        var target = node.attr('href');
        $(target).show();
        active = target;
        $('#neighborhoodMap path:not(*[rel=' + target + '])').animate({opacity: 0});
        $('#neighborhoodMap polygon:not(*[rel=' + target + '])').animate({opacity: 0});
        return false;
    }).hover(function(e) {
        var node = $(this);
        var target = node.attr('href');

        if(target == active)
            return false;

        $('#neighborhoodMap path[rel=' + target + '], #neighborhoodMap polygon[rel=' + target + ']').animate({opacity: 1});
    }, function(e) {
        var node = $(this);
        var target = node.attr('href');

        if(target == active)
            return false;

        $('#neighborhoodMap path[rel=' + target + '], #neighborhoodMap polygon[rel=' + target + ']').animate({opacity: 0});
    });


    });
    var active;

    // Equal Heights for Columns (Fixes some floating issues)
    $('.columnSet').each(function(i, set) {
            var set = $(set);
            var max_height = 0;
            set.children('div').each(function(j, column) {
            if ($(this).height() > max_height) { max_height = $(this).height(); }
        })

        set.children('div').height(max_height);
    })
        // For Specific Fixes - Equal Heights for Columns (Fixes some floating issues)
        var max_height = 0;
        $('#weekSummary div.day div.description').each(function(j, column) {
            if ($(this).height() > max_height) { max_height = $(this).height(); }
        })
        $('#weekSummary div.day div.description').height(max_height);

    // Misc styles stuff
    $('.articleBody div.twoCol div.col.listing p:even').addClass('alt');
