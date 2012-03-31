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

	$('#bye').click(function(ev){
		$('.overlay').fadeOut();
	}); 

	$(window).bind("resize", resizeWindow);

	$(document).keyup(function(e) {
		if (e.keyCode == 27) { $('.overlay').fadeOut(); }   // esc
	});
	

 

});          

function resizeWindow( e ) {
		var newWindowWidth = $(window).width();

		/* 
		var newWindowHeight = $(window).height();
		$("#container").css("min-height", newWindowHeight );
		*/
		if(newWindowWidth > 1280) {
			$("#videokupa").addClass("biggest")
		}
		else if(newWindowWidth < 1280) { 	
			$("#videokupa").removeClass("biggest")
		}
	}                                           
