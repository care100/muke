function completeAndClose(){
	window.parent.closeStudy();
}
function completeChap(){
	var chapter = window.location.pathname.substr(1);
	$.ajax({
		type: "post",
        url: "/chapster",
        data: {"chap":chapter,"status": -1},
        dataType: "json",
        beforeSend: function(){
        	console.log(chapter);
        },
        success: function(data){
        	console.log(data);
        	console.log(JSON.stringify(data));
        },
        error: function(){
        	console.log("error");
        }
	});
}

$('.close-btn').click(function(){
	completeAndClose();
});

//completeChap();