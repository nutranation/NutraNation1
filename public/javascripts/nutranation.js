$('a.about-link').click(function () { 
	$(".about_text").show();
	$(".contact_text").hide();
});

$('a.contact-link').click(function () { 
	$(".about_text").hide();
	$(".contact_text").show();
});

$('div.close_x').click(function () { 
	$(".about_text").hide();
	$(".contact_text").hide();
});


$("div.close_x_sign").click(function () { 
	$(".layer").hide();
});