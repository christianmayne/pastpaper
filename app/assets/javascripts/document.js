function remove_fields (link) {
 /* $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
  */
  $(link).siblings("input[type=hidden]:first").attr('value', '1');
	$(link).parents(".fields:first").hide();
  
}

/*function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  /*$(link).next().({
    before: content.replace(regexp, new_id)
  });
  */
  
 /* $(link).next().html(content.replace(regexp, new_id));
  //alert(content.replace(regexp, new_id));
  // $(link).next().before(content.replace(regexp, new_id));
}
*/
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}


$(function() {
  $(".ajaxpaging .pagination a").live("click", function() {
    $(".ajaxpaging .pagination").html("Page is loading...");
    $.getScript(this.href);
    return false;
  });
});

function hideshowpdetail(elem)
{
	var a='#pdetail_'+elem;
	var link=$("#viewlink_"+elem);
	
	if(link.html()=="View")
		{
		link.html("hide");
		}else{
			link.html("View");
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
	if(viewlink.html()=="View")
		{viewlink.html("Hide");}
	else
		{viewlink.html("View");}
	
}