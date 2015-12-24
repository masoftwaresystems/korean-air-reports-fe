(function(){
	window.emailItinerary = function(){
		var items = jQuery("#itinerary-items .itinerary-item:visible");
		var currentBody = jQuery("#emailItineraryHolder textarea").val();
		var items = jQuery("#itinerary-items .itinerary-item:visible");
		var itemsLength = items.length;
		currentBody += "\n\n";
		for(var i=0; i<itemsLength; i++){
			var item = jQuery(items[i]);
			var displayIndex = i+1;
			currentBody += displayIndex + ". " + item.find(".your-itinerary-title").html() + "\n";
			currentBody += "   " + item.find(".your-itinerary-summary").html() + "\n";
		}
		jQuery("#emailItineraryHolder textarea").val(currentBody);
		jQuery("#emailItineraryHolder").modal();
		jQuery("#emailGoButton").click(function(){
			var sendEmail = true
			jQuery("#emailItineraryHolder input[type=text]").each(function(){
				if(jQuery(this).val().length === 0){
					sendEmail = false;
					return;
				}
			});
			if(!jQuery("#emailItineraryHolder textarea").val().length){
				sendEmail = false;
			}
			if(sendEmail){
				var params = jQuery(this).parents("form").serialize();
				jQuery.post("/templates/Module-Send_Email?" + params, function(response){
					jQuery.modal.close();
				});	
			}
			return false;
		})
	}
	window.getEventSort = function(){
		var sortData = [];
		var sortStr = jQuery.cookie("eventSort");
		if(sortStr){
			sortData = sortStr.split(",");
		}
		return sortData;
	}
	window.setEventSort = function(sortData){
		if(!sortData){
			sortData = [];
		}
		jQuery.cookie("eventSort", sortData.toString());
		return sortData;
	}
	window.setEventItem = function(eventItem){
		jQuery.cookie("eventItem-" + eventItem.id, JSON.stringify(eventItem));
	}
	window.removeEventItem = function(eventId){
		jQuery.cookie("eventItem-" + eventId, null);
	}
	window.getEventItem = function(id){
		return jQuery.cookie(id);
	}
	window.validateEventSort = function(sortData){
		var verified = {};
		var newSortData = [];
		var newIndex = 0;
		var length = sortData.length;
		var resave = false;
		for(var i=0; i<length; i++){
			var eventId = sortData[i];
			if(!verified[eventId]){
				var eventObj = jQuery.cookie(eventId);
				if(eventObj){
					newSortData[newIndex++] = eventId;
					verified[eventId] = true;
				} else {
					resave = true;
				}
			} else {
				resave = true;
			}
		}
		if(resave){
			setEventSort(newSortData);
		}
		return newSortData;
	}
	window.sortEvents = function(sortData){
		var items = jQuery("#itinerary-items .itinerary-item:visible");
		var itemsLength = items.length;
		
		for(var i=0; i<itemsLength; i++){
			sortData[i] = "eventItem-" + getEventId(items[i].id);
		}
		setEventSort(sortData);
	};
	window.applyEventSorting = function(sortData){
		jQuery("#itinerary-items").sortable({
			update: function(e){
				sortEvents(sortData);
			}
		});
	}
	window.getEventId = function(eventStr){
		return eventStr.match("[^-]-([^-]*)$")[1];
	}
	window.generateItineraryHtml = function(eventObj){
		var copyHtml = jQuery("#copy-itinerary-item").clone();
		copyHtml.find("#redXRemove").attr("id", "redXRemove-" + eventObj.id);
		copyHtml.find(".your-itinerary-title").html(eventObj.title);
		copyHtml.find(".your-itinerary-summary").html(eventObj.summary);
		copyHtml.attr("id", "your-itinerary-" + eventObj.id);
		copyHtml.css({"display":"block"});
		copyHtml.addClass("itinerary-item");
		return copyHtml;
	}
	window.addToItinerary = function(e, sortData){
		if(sortData && sortData.length == 8){
			$.modal("<div><h1>No more than 8 items can be added to your itinerary</h1></div>", {
				containerCss: {
					height:"60px",
					width: "400px"
				}
			});
			return;
		}
		var element = jQuery(e.currentTarget);
		var idString =  getEventId(element.attr("id"));
		var eventObj = itineraryEvents["eventItem-" + idString];
		if(eventObj){
			var html = generateItineraryHtml(eventObj);
			jQuery("#itinerary-items").append(html);
			var sortDataLength = sortData.length;
			if(sortDataLength == 0){
				applyEventSorting(sortData);
				jQuery("#noItineraryMessage").hide();
				jQuery("#mi-share-this").show();
			} else {
				jQuery("#itinerary-items").sortable("refresh");
			}
			sortData[sortDataLength] = "eventItem-" + eventObj.id;
			setEventItem(eventObj);	
			setEventSort(sortData);
			changeActionsToRemoveForItem(eventObj.id);
		}
		return sortData;
	};
	window.removeFromItinerary = function(e, sortData){
		var element = jQuery(e.currentTarget);
		var idString =  getEventId(element.attr("id"));
		jQuery("#" + "your-itinerary-" + idString).remove();
		var showNoItinerary = false;
		if(sortData.length - 1 === 0){
			showNoItinerary = true;
			jQuery("#dragToRearrange").hide();
			jQuery("#itinerary-items").sortable("destroy");
		} else {
			jQuery("#itinerary-items").sortable("refresh");
		}
		sortData = [];
		sortEvents(sortData);
		removeEventItem(idString);
		setEventSort(sortData);
		changeActionsToAddForItem(idString);
		if(showNoItinerary){
			jQuery("#noItineraryMessage").show();
			jQuery("#mi-share-this").hide();
		}
		return sortData;	
	}
	window.changeActionsToRemoveForItem = function(id){
		var elements = jQuery(".itineraryAction-" + id);
		elements.removeClass("addToItinerary");
		elements.addClass("removeFromItinerary");
		elements.find("span").html("Remove from your Itinerary");
	}
	window.changeActionsToAddForItem = function(id){
		var elements = jQuery(".itineraryAction-" + id);
		elements.removeClass("removeFromItinerary");
		elements.addClass("addToItinerary");
		elements.find("span").html("Add to your Itinerary");
	}
})();
