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
  	itemSelector: '.movie',
  	isFitWidth: true
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

	$("#featured a.close").click(function(e){
		$("#featured").fadeOut();
	});

	$("#categories .switcher li a").click(function(e){
		$("#categories .switcher li a").removeClass();
		$("#moviesList").html("<div class='loader'></div>");
		$(this).addClass("active");

		var item = $(this).parent().attr("id")
		switch(item){
			case 'switcherItem1': 
				$("#categories #switcherItem1").animate({marginLeft:'90px'}, 100);
				break;
			case 'switcherItem2': 
				$("#categories #switcherItem1").animate({marginLeft:'3px'}, 100);
				break;
			case 'switcherItem3': 
				$("#categories #switcherItem1").animate({marginLeft:'-84px'}, 100);		
				break;
		}
	});  /* TEMP SHIT */

	$('[rel="tooltip"]').tooltip();

	$('.next_page').click(function(e){
		$(".pagination").html("<div class='loader'></div>");
	});

	/* pagination auto click */
	$(window).scroll(function(){
		var scroll_top = $(document).scrollTop()
		var window_height = $(window).height()
		var document_height = $(document).height()
		if(scroll_top + window_height == document_height){
			$(".next_page").trigger('click');
		}
	});



});


function lightboxButtons(ev) {
	$('#bye').click(function(ev){
		$('.overlay').fadeOut();
	});
	/* not needed because of partial reload
	$('#cinema .actions input').click(function() {
		$('#cinema .actions input').removeClass('active');
		$(this).toggleClass('active');
	});
	*/
	
	$('#cinema .actions #comments').click(function() {
		var sidepanel = $('#lightbox_content').hasClass('sidepanel');
		if (sidepanel == true) {
			$(this).removeClass('active');
			$('#lightbox_content').removeClass('sidepanel');
		}
		else {
			$(this).addClass('active');
			$('#lightbox_content').addClass('sidepanel');
		}
	});
	var sidepanel = $('#lightbox_content').hasClass('sidepanel');
	if (sidepanel == true) {
		$('#cinema .actions #comments').addClass('active');
	}

	$('.popover').remove();
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
