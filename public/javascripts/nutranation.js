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


$('a.fb_connect_button').click(function () { 
	$.ajax({
	  url: 'http://www.nutranation.org/users/auth/facebook',
	  success: function(data) {
	  	$(".layer").show();
	  },
		error:function (xhr, ajaxOptions, thrownError){
	                    alert(xhr.statusText);
	                    alert(thrownError);
	                }
	});
	
})

$("div.close_x_sign").click(function () { 
	$(".layer").hide();
});