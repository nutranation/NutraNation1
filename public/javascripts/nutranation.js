$("div.about_headline").click(function () { 
	$(".learnmore_about").show() 
	$(".learnmore_nav").show();
	$(".learnmore_box").show();
	$(".first-about").show()
	$(".second-about").hide()
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").hide()
	$('body').scrollTo($(".target"), 2500, {easing:'linear'});		
});

$("a.about-link").click(function () { 
	$(".learnmore_nav").show();
	$(".learnmore_box").show();
	$(".learnmore_about").show() 
	$(".first-about").show();
	$(".second-about").hide();
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").hide() 
	$('body').scrollTo($(".target"), 2500, {easing:'linear'});		
});

$("a.contact-link").click(function () { 
	$(".learnmore_nav").show();
	$(".learnmore_box").show();
	$(".learnmore_about").hide()
	$(".first-about").hide();
	$(".second-about").hide(); 
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").show()
	$('body').scrollTo($(".target"), 2500, {easing:'linear'});		
});

$("li.contact_nav").click(function () { 
	$(".learnmore_nav").show();
	$(".learnmore_box").show();
	$(".learnmore_about").hide();
	$(".first-about").hide();
	$(".second-about").hide();
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").show()
	$('body').scrollTo($(".target"), 2500, {easing:'linear'});		
});

$("li.about_nav").click(function () { 
	$(".learnmore_nav").show();
	$(".learnmore_box").show();
	$(".learnmore_about").show() 
	$(".first-about").show();
	$(".second-about").show();
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").hide()
	$('body').scrollTo($(".target"), 2500, {easing:'linear'});		
});




$("div.close_x_sign").click(function () { 
	$(".layer").hide();
});



$('#button_signup').click(function (){
	email = $('.email_input').val();
	$.ajax({
	  url: '/register?email='+email,
	  success: function(data) {
			$(".layer").slideDown();
	  },
		error:function (xhr, ajaxOptions, thrownError){
	                  
	                    alert("Email Previously Submitted");
	                }
	});

});