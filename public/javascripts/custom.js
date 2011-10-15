$('.beta-submit').click( 
function () { 
		code  = $('.beta-code').val();
		$.ajax({
		  url: '/confirm?code='+code,
		  success: function(){
				
		  }
		});
		window.location.href=window.location.href;
		
});

