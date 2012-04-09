// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready(function(ev){	

	$(window).bind("resize", resizeWindow);
	$(document).keyup(function(e) {
		if (e.keyCode == 27) { $('.overlay').fadeOut(); }   // esc
	});

	$('#moviesList').masonry({
  	itemSelector: '.movie'
	});

	function popupCenter(url, width, height, name) {
	  var left = (screen.width/2)-(width/2);
	  var top = (screen.height/2)-(height/2);
	  return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
	}

	$("a.facebook_popup").click(function(e) {
	  popupCenter($(this).attr("href"), 600, 400, "authPopup");
	  e.stopPropagation(); return false;
	});	
});


function lightboxButtons(ev) {
	$('#bye').click(function(ev){
		$('.overlay').fadeOut();
	});
	$('#cinema .actions input').click(function() {
		$('#cinema .actions input').removeClass('active');
		$(this).toggleClass('active');
	});
	$('#cinema .actions #comments').click(function() {
		$(this).toggleClass('active');
		$('#lightbox_content').toggleClass('sidepanel');
	});
	$('#nice').popover({placement: 'left'});
	$('#bad').popover({placement: 'left'});

}           

function resizeWindow( e ) {
	var newWindowWidth = $(window).width();
	/* 
	var newWindowHeight = $(window).height();
	$("#container").css("min-height", newWindowHeight );
	*/
	if(newWindowWidth > 1280) {
		$("#embed_video").addClass("biggest")
	}
	else if(newWindowWidth < 1280) { 	
		$("#embed_video").removeClass("biggest")
	}
}                                           
