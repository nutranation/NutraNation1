$("div.about_headline").click(function () { 
	$(".learnmore_about").slideDown() 
	$(".learnmore_nav").slideDown();
	$(".learnmore_box").slideDown();
	$(".first-about").slideDown()
	$(".second-about").hide()
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").hide() 
});

$("a.about-link").click(function () { 
	$(".learnmore_nav").slideDown();
	$(".learnmore_box").slideDown();
	$(".learnmore_about").slideDown() 
	$(".first-about").slideDown();
	$(".second-about").hide();
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").hide() 
});

$("a.contact-link").click(function () { 
	$(".learnmore_nav").slideDown();
	$(".learnmore_box").slideDown();
	$(".learnmore_about").hide()
	$(".first-about").hide();
	$(".second-about").hide(); 
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").slideDown() 
});

$("li.contact_nav").click(function () { 
	$(".learnmore_nav").slideDown();
	$(".learnmore_box").slideDown();
	$(".learnmore_about").hide();
	$(".first-about").hide();
	$(".second-about").hide();
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").slideDown() 
});

$("li.about_nav").click(function () { 
	$(".learnmore_nav").slideDown();
	$(".learnmore_box").slideDown();
	$(".learnmore_about").slideDown() 
	$(".first-about").slideDown();
	$(".second-about").slideDown();
	$(".box_footerlinks_text").hide() 
	$(".learnmore_contact").hide() 
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