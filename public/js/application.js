var flickr_json_feed = "http://api.flickr.com/services/feeds/photos_public.gne?id=8276533@N04&lang=en-us&format=json&jsoncallback=?";
var twitter_json_feed = "http://twitter.com/statuses/user_timeline/14567219.json?count=5&callback=?";

$(document).ready(function(){
	/* get flickr feed and show last 4 thumbnails */
	$.getJSON(flickr_json_feed, function(data){
	  $.each(data.items, function(i,item){
	    $("<img/>").attr("src", item.media.m.replace('_m.jpg','_s.jpg')).appendTo("#flickr").wrap("<a href='" + item.link + "' title='" + item.title + "'></a>");
	    if(i == 3) return false;
	  });
  });

	/* get twitter feed and display last 5 messages */
	$.getJSON(twitter_json_feed,function(data){
		$.each(data, function(i,item){
			$("<p>").html("<a href='http://twitter.com/coffeerings/status/" + item.id + "'>" + item.text + "</a>").appendTo('#twitter');
			if(i == 4) return false;
		});
	});
	
	$("#title").keyup(function(){
    $("#url").attr('value',$(this).val().replace(/\s+/g,'-'));
  });	
});