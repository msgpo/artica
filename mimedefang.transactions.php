<?php
	if(isset($_GET["verbose"])){$GLOBALS["VERBOSE"]=true;ini_set('display_errors', 1);ini_set('error_reporting', E_ALL);ini_set('error_prepend_string',null);ini_set('error_append_string',null);}
	$GLOBALS["ICON_FAMILY"]="ANTISPAM";
	include_once('ressources/class.templates.inc');
	include_once('ressources/class.ldap.inc');
	include_once('ressources/class.users.menus.inc');
	include_once('ressources/class.postgres.inc');

	$user=new usersMenus();
	if(isset($_GET["items"])){items();exit;}
	popup();
	





function popup(){
	$page=CurrentPageName();
	$tpl=new templates();	
	$users=new usersMenus();
	$TB_HEIGHT=300;
	$TB_WIDTH=880;
	
	
	$t=time();
	$new_entry=$tpl->_ENGINE_parse_body("{new_rule}");
	$from=$tpl->_ENGINE_parse_body("{sender}");
	$to=$tpl->_ENGINE_parse_body("{recipients}");
	$title=$tpl->_ENGINE_parse_body("&laquo;{transactions}&raquo;");
	$reason=$tpl->_ENGINE_parse_body("{reason}");
	$ask_delete_rule=$tpl->javascript_parse_text("{delete_this_rule}");
	$hostname=$tpl->_ENGINE_parse_body("{hostname}");
	$compile_rules=$tpl->_ENGINE_parse_body("{compile_rules}");
	$ipaddr=$tpl->_ENGINE_parse_body("{ipaddr}");
	$zdate=$tpl->javascript_parse_text("{date}");
	$size=$tpl->javascript_parse_text("{size}");
	$status=$tpl->javascript_parse_text("{status}");
	$subject=$tpl->javascript_parse_text("{subject}");
	$report=$tpl->javascript_parse_text("{report}");
	$buttons="
	buttons : [
	{name: '<strong style=font-size:18px>$new_entry</strong>', bclass: 'Add', onpress : NewGItem$t},
	
	
	],	";
	$buttons=null;
	
	$html="
	<table class='flexRT$t' style='display: none' id='flexRT$t' style='width:99%'></table>
<script>
var mem$t='';
$(document).ready(function(){
$('#flexRT$t').flexigrid({
	url: '$page?items=yes&t=$t',
	dataType: 'json',
	colModel : [	
		{display: '<span style=font-size:18px>&nbsp;</span>', name : 'zdate', width :55, sortable : true, align: 'center'},
		{display: '<span style=font-size:18px>$report</span>', name : 'spamreport', width :55, sortable : true, align: 'center'},
		{display: '<span style=font-size:18px>$zdate</span>', name : 'zdate', width :119, sortable : true, align: 'left'},
		{display: '<span style=font-size:18px>$from</span>', name : 'mailfrom', width :330, sortable : true, align: 'left'},
		{display: '<span style=font-size:18px>$to</span>', name : 'mailto', width :203, sortable : true, align: 'left'},
		{display: '<span style=font-size:18px>$status</span>', name : 'status', width :107, sortable : false, align: 'left'},
		{display: '<span style=font-size:18px>$size</span>', name : 'size', width :92, sortable : true, align: 'right'},
		{display: '<span style=font-size:18px>$subject</span>', name : 'subject', width :410, sortable : true, align: 'left'},
		

	],
	$buttons

	searchitems : [
		{display: '$from', name : 'mailfrom'},
		{display: '$to', name : 'mailto'},
		{display: '$subject', name : 'subject'},
		
	],
	sortname: 'zdate',
	sortorder: 'desc',
	usepager: true,
	title: '<span style=font-size:30px>$title</span>',
	useRp: true,
	rp: 50,
	showTableToggleBtn: false,
	width: '99%',
	height: 550,
	singleSelect: true,
	rpOptions: [10, 20, 30, 50,100,200,500]
	
	});   
});

function ItemHelp$t(){
	s_PopUpFull('http://www.mail-appliance.org/index.php?cID=305','1024','900');
}


var x_NewGItem$t=function(obj){
	var tempvalue=obj.responseText;
    if(tempvalue.length>3){alert(tempvalue);}
    $('#flexRT$t').flexReload();
}

function NewGItem$t(){
	YahooWin('650','$page?rulemd5=&t=$t','$new_entry');
	
}
function GItem$t(zmd5,ttile){
	YahooWin('650','$page?rulemd5='+zmd5+'&t=$t',ttile);
	
}

var x_DeleteAutCompress$t=function(obj){
	var tempvalue=obj.responseText;
    if(tempvalue.length>3){alert(tempvalue);return;}
    $('#rowC'+mem$t).remove();
}

function GroupAmavisExtEnable(id){
	var value=0;
	if(document.getElementById('gp'+id).checked){value=1;}
 	var XHR = new XHRConnection();
    XHR.appendData('enable-gp',id);
    XHR.appendData('value',value);
    XHR.sendAndLoad('$page', 'POST',x_NewGItem$t);		
}


function DeleteAutCompress$t(md5){
	if(confirm('$ask_delete_rule')){
		mem$t=md5;
 		var XHR = new XHRConnection();
      	XHR.appendData('del-zmd5',md5);
      	XHR.sendAndLoad('$page', 'POST',x_DeleteAutCompress$t);		
	
	}

}

</script>";
	
	echo $html;
}

function items(){
	//1.4.010916
	$t=$_GET["t"];
	$tpl=new templates();
	$MyPage=CurrentPageName();
	$q=new postgres_sql();
	$users=new usersMenus();	
	
	$search='%';
	$table="smtpstats";
	$page=1;
	$FORCE_FILTER="";
	
	if(!$users->AsPostfixAdministrator){
		if($users->AsMessagingOrg){
			$ldap=new clladp();
			$domains=$ldap->hash_get_domains_ou($_SESSION["ou"]);
			
			while (list ($domain,$MAIN) = each ($domains) ){
				$domain=trim(strtolower($domain));
				if($domain==null){continue;}
				$FDOMS[]="domainto = '$domain'";
				$FDOMS2[]="domainfrom = '$domain'";
			}
			$imploded1=@implode(" OR ", $FDOMS);
			$imploded2=@implode(" OR ", $FDOMS2);
			$table="(select * FROM smtpstats WHERE ($imploded1) OR ($imploded2)) as t";
		}
		
	}
	

	if(isset($_POST["sortname"])){if($_POST["sortname"]<>null){$ORDER="ORDER BY {$_POST["sortname"]} {$_POST["sortorder"]}";}}	
	if(isset($_POST['page'])) {$page = $_POST['page'];}
	
	$searchstring=string_to_flexPostGresquery();
	$sql="SELECT COUNT(*) as tcount FROM $table WHERE $searchstring";
	$ligne=pg_fetch_array($q->QUERY_SQL($sql));
	$total = $ligne["tcount"];
		
	
	if (isset($_POST['rp'])) {$rp = $_POST['rp'];}	
	

	
	$pageStart = ($page-1)*$rp;
	$limitSql = "LIMIT $rp OFFSET $pageStart";
	
	$sql="SELECT *  FROM $table WHERE $searchstring $FORCE_FILTER $ORDER $limitSql";	
	$results = $q->QUERY_SQL($sql);
	
	$data = array();
	$data['page'] = $page;
	$data['total'] = $total;
	$data['rows'] = array();
	
	if(!$q->ok){json_error_show($q->mysql_error);}	
	if(pg_num_rows($results)==0){json_error_show("no rule");}
	while ($ligne = pg_fetch_assoc($results)) {
	$color="#000000";
	$spamreport_icon="&nbsp;";
	$zmd5=$ligne["zmd5"];
	$icon="ok24.png";
	$spamscore_text=null;
	$status=$tpl->_ENGINE_parse_body("{sent}");
	$subject=$ligne["subject"];
	$spamscore=$ligne["spamscore"];
	$infected=$ligne["infected"];
	$spamreport=$ligne["spamreport"];

	if(strlen($spamreport)>20){
		$spamreport_icon="<center><img src='img/scripts-24.png' OnClick=\"javascript:Loadjs('$MyPage?spam-report-js=yes&zmd5=$zmd5');\"></center>";
	}
	$whitelisted=intval($ligne["whitelisted"]);
	$size=FormatBytes($ligne["size"]/1024);
	if($spamscore>0){
		$spamscore_text="&nbsp;AS: $spamscore";
	}
	if($spamscore>=5){
		$icon="warning24.png";
	}
	if($spamscore>=10){
		$icon="danger24.png";
	}
	if($infected==1){
		$status=$status."/".$tpl->_ENGINE_parse_body("{infected}");
		$icon="danger24.png";
	}
	
	if($whitelisted==1){$icon="whitelist-24.png";}
	
	$data['rows'][] = array(
		'id' => "C$zmd5",
		'cell' => array(
			"<center style='font-size:13px;color:$color'><img src='img/$icon'></center>",
			"<center style='font-size:13px;color:$color'>$spamreport_icon</center>",
			"<span style='font-size:13px;color:$color'>{$ligne["zdate"]}</a></span>",
			"<span style='font-size:13px;color:$color'>{$ligne["mailfrom"]}</a></span>",
			"<span style='font-size:13px;color:$color'>{$ligne["mailto"]}</a></span>",
			"<span style='font-size:13px;color:$color'>{$status}{$spamscore_text}</a></span>",
			"<span style='font-size:13px;color:$color'>{$size}</a></span>",
			"<span style='font-size:13px;color:$color'>{$subject}</a></span>",
			)
		);
	}
	
	
echo json_encode($data);	
	
}







