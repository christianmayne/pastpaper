function remove_fields (link) {
 /* $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
  */
  $(link).prevAll("input[type=hidden]:first").attr('value', '1');
	$(link).parents(".fields:first").hide();
  
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function replace_with_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).prev().hide();
  $(link).before(content.replace(regexp, new_id));
  $(link).hide();
}

function restore_replaced_fields(link) {
  var h = $(link).prevAll("input[type=hidden]:first");
  h.prev().show();
  h.remove(); //attr('value', '1');
  var f = $(link).siblings(".fields:first");
  f.next().show();
  f.remove();
  $(link).remove();
  
}

$(function() {
  	$(".ajaxpaging .pagination a").live("click", function() {
    $(".ajaxpaging .pagination").html("Page is loading...");
    $.getScript(this.href);
    return false;
  });
  enablesellprice();
  
  $("#document_status_id").change(
  		function(){	enablesellprice();  }
  		)
  		$( ".button").button();
  		$( ".accordion" ).accordion({ collapsible: true,active: false  });
  		
  		
	});

function hideshowpdetail(elem)
{
	var a='#pdetail_'+elem;
	var link=$("#viewlink_"+elem);
	
	if(link.html()=="<i class=\"icon-zoom-in\"></i>")
		{
		link.html("<i class=\"icon-zoom-out\"></i>");
		}else{
			link.html("<i class=\"icon-zoom-in\"></i>");
		}
	$(a).toggle();
}

function hideshowldetail(elem)
{
	var a='#ldetail_'+elem;
	var link=$("#viewlocation_"+elem);
	
	if(link.html()=="<i class=\"icon-zoom-in\"></i>")
		{
		link.html("<i class=\"icon-zoom-out\"></i>");
		}else{
			link.html("<i class=\"icon-zoom-in\"></i>");
		}
	$(a).toggle();
}



function expandAllPdetail()
{
	var link=$("#expandallpdetail");
	
	if(link.html()=="Expand All")
		{link.html("Collapse All");	}
	else
		{link.html("Expand All");}	
	var items_to_show='.pdetail';
	$(items_to_show).toggle();
		
	var viewlink= $('.viewlink');	
	if(viewlink.html()=="<i class=\"icon-zoom-in\"></i>" )
		{viewlink.html("<i class=\"icon-zoom-out\></i>");}
	else
		{viewlink.html("<i class=\"icon-zoom-in\"></i>");}
}

function toggle_div(div, show_text, hide_text, id)
{
  var div_to_toggle=div;
  var link=$("#"+id);

  if (link.html()==hide_text) {
    link.html(show_text);
  }
  else {
    link.html(hide_text);
  }

  $(div_to_toggle).toggle();
}




function enablesellprice()
  {
  	  if($("#document_status_id").val()==4)
	  {
	  	    $("#sell_price").show();
	  }else{
	  	    $("#sell_price").hide();
	  }
 }
 




// to enable ajax pop up 
$(document).on('click', '.ajaxmodal', function(){
	
		$('#modal-window').modal('show');
		
		$('#modal-window .modal-footer').remove();
  });
