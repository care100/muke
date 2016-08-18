function completeAndClose(){
	window.parent.closeStudy();
}
var chapter = window.location.href.split('?')[1].split('=')[1];
function completeChap(){
	
	if(isLogin()){
		$.ajax({
			type: "post",
	        url: "/chapster",
	        data: {"chap":chapter,"status": -1},
	        dataType: "json",
	        success: function(data){
	        	console.log(data.status);
	        },
	        error: function(){
	        	console.log("error");
	        }
		});
	}else{
		localStorage.setItem("chap"+chapter,-1);
	}
}

$('.close-btn').click(function(){
	completeAndClose();
});

if(localStorage.getItem("chap"+chapter) == null){
	localStorage.setItem("chap"+chapter,1);
}

//completeChap();