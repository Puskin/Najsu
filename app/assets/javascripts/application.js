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

$(window).load(function(ev){	
	var hash = location.hash;
	if(hash.indexOf("movie") != -1) {
		var movie_id = hash.substring(7);
		document.location="/movies/"+movie_id
	}
	$("#slidabilty").animate({marginTop:'0px'}, 220);
});

$(document).ready(function(ev){	

	$(window).bind("resize", resizeWindow);
	$(document).keyup(function(e) {
		if (e.keyCode == 27) {
			$('iframe').remove(); 
			$('.overlay').fadeOut(); 
		}   // esc
	});

	window.onresize = function(event) {
		var window_height = $(window).height();
		$('#activities_baloon').css("height", window_height-120);
		$('#counter_activities').css("height", window_height-148);
		$('#lightbox_comments').css("height", window_height-120);			
		$('#lightbox_comments ul').css("height", window_height-150);		
	};

	$(".btn-group a").click(function(e){
		$(".btn-group a").removeClass("active");
		$(this).addClass("active");
	});

	$("#mobile_activities_close").click(function(e){
		$("#activities_baloon").slideUp("fast");
	});


  $("#searchPeople #search").keyup(function() {
    $.get($("#searchPeople").attr("action"), $("#searchPeople").serialize(), null, "script");
    return false;
  });
	




	// hide mini feed if clicked outside
	$('html').click(function() {
 		$("#activities_baloon").slideUp("fast");
 	});
 	// dont hide when clicking in mini feed
	$('#activities_baloon').click(function(event){
     event.stopPropagation();
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
			case 'switcherItem0': 
				$("#categories #switcherItem0").animate({marginLeft:'179px'}, 100);
				break;
			case 'switcherItem1': 
				$("#categories #switcherItem0").animate({marginLeft:'90px'}, 100);
				break;
			case 'switcherItem2': 
				$("#categories #switcherItem0").animate({marginLeft:'3px'}, 100);
				break;
			case 'switcherItem3': 
				$("#categories #switcherItem0").animate({marginLeft:'-84px'}, 100);		
				break;
			case 'switcherItem4': 
				$("#categories #switcherItem0").animate({marginLeft:'-169px'}, 100);		
				break;
		}
	});  /* TEMP SHIT */

	$('[rel="tooltip"]').tooltip();
	$('[rel="tooltipBottom"]').tooltip({placement: "bottom"});
	$('[rel="tooltipLeft"]').tooltip({placement: "left"});


	$('.next_page').click(function(e){
		$(".pagination").html("<div class='loader'></div>");
	});

	/* pagination auto click */
	$(window).scroll(function(){
		var scroll_top = $(document).scrollTop()
		var window_height = $(window).height()
		var document_height = $(document).height()
	
		if(scroll_top + window_height == document_height){
			setTimeout(function () { $(".next_page").trigger('click'); }, 0);		
		}

		if(scroll_top > 15) {
			$(".navbar-inner").addClass("shadow");
		} else if (scroll_top < 15){
			$(".navbar-inner").removeClass("shadow");
		}		
	});

	init: heightCheck();

});




function heightCheck() {
	var scroll_top = $(document).scrollTop()
  var window_height = $(window).height();
	var document_height = $(document).height();
	if(window_height == document_height){		
		$(".next_page").trigger('click');		
	} else if(scroll_top==0 && window_height < document_height){
		$(".next_page").trigger('click');		
	}
}


function lightboxButtons(ev) {
	$('#bye').click(function(ev){
		$('iframe').remove();
		$('.overlay').fadeOut();
		document.location="#feed";
	});
	/* not needed because of partial reload
	$('#cinema .actions input').click(function() {
		$('#cinema .actions input').removeClass('active');
		$(this).toggleClass('active');
	});
	*/
	

	/* OLD COMMENTS IMPLEMENTATION 
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
	*/

	$('#cinema .actions #comments').click(function() {
		var sidepanel = $('#lightbox_comments').hasClass('active');
		if (sidepanel == true) {
			$(this).removeClass('active');
			$('#lightbox_comments').removeClass('active');
			$('#lightbox_comments').fadeOut('fast');
		}
		else {
			$(this).addClass('active');
			$('#lightbox_comments').addClass('active');
			$('#lightbox_comments').fadeIn('normal');
			var window_height = $(window).height();
			$('#lightbox_comments').css("height", window_height-120);			
			$('#lightbox_comments ul').css("height", window_height-150);			
		}
	});
	var sidepanel = $('#lightbox_comments').hasClass('active');
	if (sidepanel == true) {
		$('#cinema .actions #comments').addClass('active');
	}




	$('.popover').remove();
	$('#like').popover({placement: 'left'});
	$('[rel="tooltipLeft"]').tooltip({placement: "left"});
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
