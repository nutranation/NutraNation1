$('.beta-submit').click( 
function () { 
		code  = $('.beta-code').val();
		$.ajax({
		  url: '/confirm?code='+code,
		  success: function(data){
				$('body').html(data);
		  }
		});

		
});

$('.request-submit').click(
	function () { 
		window.location.href='/'
	});

