<?php
ini_set('memory_limit','1000M');
header("Pragma: no-cache");
header("Expires: 0");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
header("Cache-Control: no-cache, must-revalidate");
$GLOBALS["BASEDIR"]="/usr/share/artica-postfix/ressources/interface-cache";
if(isset($_GET["verbose"])){$GLOBALS["VERBOSE"]=true;ini_set('display_errors', 1);ini_set('error_reporting', E_ALL);ini_set('error_prepend_string',null);ini_set('error_append_string',null);}
include_once('ressources/class.templates.inc');
include_once('ressources/class.ldap.inc');
include_once('ressources/class.users.menus.inc');
include_once('ressources/class.artica.inc');
include_once('ressources/class.ini.inc');
include_once('ressources/class.squid.inc');
include(dirname(__FILE__)."/ressources/class.influx.inc");


	$user=new usersMenus();
	if(!$user->AsWebStatisticsAdministrator){
		echo FATAL_ERROR_SHOW_128("{ERROR_NO_PRIVS}");
		exit;
	}
	
	if(isset($_GET["main"])){main_page();exit;}
	if(isset($_GET["stats-requeteur"])){stats_requeteur();exit;}
	if(isset($_GET["requeteur-popup"])){requeteur_popup();exit;}
	if(isset($_GET["requeteur-js"])){requeteur_js();exit;}
	if(isset($_GET["remove-cache-js"])){remove_cache_js();exit;}
	if(isset($_GET["remove-cache"])){remove_cache_button();exit;}
	if(isset($_POST["remove-cache"])){remove_cache();exit;}
	if(isset($_GET["query-js"])){build_query_js();exit;}
	
	if(isset($_GET["table3"])){table3();exit;}
	if(isset($_GET["graph3"])){graph3();exit;}	

	if(isset($_GET["table4"])){table4();exit;}
	if(isset($_GET["graph4"])){graph4();exit;}
	
	if(isset($_GET["table5"])){table5();exit;}
	if(isset($_GET["graph5"])){graph5();exit;}	
	

	
page();

function stats_requeteur(){
	$tpl=new templates();
	$page=CurrentPageName();

	$ahref_sys="<a href=\"javascript:blur();\"
	OnClick=\"javascript:Loadjs('$page?requeteur-js=yes&t={$_GET["t"]}')\">";
	echo $tpl->_ENGINE_parse_body("$ahref_sys{build_the_query}</a>");
}
function requeteur_js(){
	header("content-type: application/x-javascript");
	$page=CurrentPageName();
	$tpl=new templates();
	$build_the_query=$tpl->javascript_parse_text("{build_the_query}::{categories}");
	echo "YahooWin('670','$page?requeteur-popup=yes&t={$_GET["t"]}','$build_the_query');";
}


function build_query_js(){
	$page=CurrentPageName();
	$tpl=new templates();
	$from=strtotime("{$_GET["date1"]} {$_GET["time1"]}");
	$to=strtotime("{$_GET["date2"]} {$_GET["time2"]}");
	$interval=$_GET["interval"];
	$t=$_GET["t"];
	$user=$_GET["user"];
	$md5=md5("WEBSITES:$from$to$interval$user{$_GET["searchsites"]}{$_GET["searchuser"]}");
	$_SESSION["SQUID_STATS_DATE1"]=$_GET["date1"];
	$_SESSION["SQUID_STATS_TIME1"]=$_GET["time1"];
	
	$_SESSION["SQUID_STATS_DATE2"]=$_GET["date2"];
	$_SESSION["SQUID_STATS_TIME2"]=$_GET["time2"];
	
	
	$timetext1=$tpl->time_to_date(strtotime("{$_GET["date1"]} {$_GET["time1"]}"),true);
	$timetext2=$tpl->time_to_date(strtotime("{$_GET["date2"]} {$_GET["time2"]}"),true);
	
	
	
	$nextFunction="LoadAjax('CATEGORIES_STATS_MAIN_GRAPH','$page?main=yes&zmd5=$md5&t=$t');";
	$nextFunction_encoded=urlencode(base64_encode($nextFunction));
	$q=new mysql_squid_builder();
	$q->CheckReportTable();
	
	$ligne=mysql_fetch_array($q->QUERY_SQL("SELECT ID,builded FROM reports_cache WHERE `zmd5`='$md5'"));
	if(intval($ligne["ID"])==0){
		$array["FROM"]=$from;
		$array["TO"]=$to;
		$array["INTERVAL"]=$interval;
		$array["USER"]=$user;
		$array["categories"]=$_GET["categories"];
		$array["searchuser"]=$_GET["searchuser"];
		
		$serialize=mysql_escape_string2(serialize($array));
		$title="{categories}: $timetext1 - {to} $timetext2 {category} {like} {$_GET["categories"]} and $user {like} {$array["searchuser"]}";
		$sql="INSERT IGNORE INTO `reports_cache` (`zmd5`,`title`,`report_type`,`zDate`,`params`) VALUES 
		('$md5','$title','CATEGORIES',NOW(),'$serialize')";
		$q->QUERY_SQL($sql);
		if(!$q->ok){echo "alert('". $tpl->javascript_parse_text($q->mysql_errror)."')";return;}
		echo "Loadjs('squid.statistics.progress.php?zmd5=$md5&NextFunction=$nextFunction_encoded')";
		return;
	}
	
	if(intval($ligne["builded"]==0)){
echo "
function Start$t(){
	Loadjs('squid.statistics.progress.php?zmd5=$md5&NextFunction=$nextFunction_encoded&t=$t');
}

if(document.getElementById('graph-$t')){
	document.getElementById('graph-$t').innerHTML='<center><img src=img/loader-big.gif></center>';
}
LockPage();	
setTimeout('Start$t()',800);
";



return;
}
	
	echo $nextFunction;
	
}
function remove_cache_js(){
	header("content-type: application/x-javascript");
	$tpl=new templates();
	$q=new mysql_squid_builder();
	$zmd5=$_GET["zmd5"];
	$ligne=mysql_fetch_array($q->QUERY_SQL("SELECT ID,`title` FROM `reports_cache` WHERE `zmd5`='$zmd5'"));
	if(!$q->ok){echo "alert('".$tpl->javascript_parse_text($q->mysql_error)."')";return;}
	$title=$tpl->javascript_parse_text("{delete} id {$ligne["ID"]} \"{$ligne["title"]}\" ($zmd5)");
	$page=CurrentPageName();
	
	
	$t=time();
echo "
var xLinkEdHosts$t= function (obj) {
	var res=obj.responseText;
	if (res.length>3){ alert(res); return; }
	
	
	if( document.getElementById('BROWSE_STATISTICS_CACHES2') ){
		$('#BROWSE_STATISTICS_CACHES2').flexReload();
	}	
	if( document.getElementById('BROWSE_STATISTICS_CACHES') ){
		$('#BROWSE_STATISTICS_CACHES').flexReload();
	}
	
	
}
	
	
function LinkEdHosts$t(){
	if(!confirm('$title ?')){return;}
	var XHR = new XHRConnection();
	XHR.appendData('remove-cache','$zmd5');
	XHR.sendAndLoad('$page', 'POST',xLinkEdHosts$t);
}
LinkEdHosts$t();
" ;
}
function remove_cache(){
	$q=new mysql_squid_builder();
	$q->QUERY_SQL("DELETE FROM reports_cache WHERE `zmd5`='{$_POST["remove-cache"]}'");
	$tpl=new templates();
	
}

function requeteur_popup(){
	$page=CurrentPageName();
	$tpl=new templates();
	squid_stats_default_values();
	$t=$_GET["t"];
	$per["10m"]="10 {minutes}";
	$per["1h"]="1 {hour}";
	$per["1d"]="1 {day}";
	$per["1w"]="1 {week}";
	$per["30d"]="1 {month}";
	
	
	$members["MAC"]="{MAC}";
	$members["USERID"]="{uid}";
	$members["IPADDR"]="{ipaddr}";
	
	
	$q=new postgres_sql();
	$Selectore=$q->fieldSelectore();
	
	
	$stylelegend="style='vertical-align:top;font-size:18px;padding-top:5px' nowrap";
	$html="<div style='width:98%;margin-bottom:20px' class=form>
	<input type='hidden' id='interval-$t' value='10m'>
	<table style='width:100%'>
	<tr>
		<td $stylelegend class=legend>{from_date}:</td>
		<td style='vertical-align:top;font-size:18px'>". field_date("from-date-$t",$_SESSION["SQUID_STATS_DATE1"],";font-size:18px;width:160px",$Selectore)."
		&nbsp;".Field_text("from-time-$t",$_SESSION["SQUID_STATS_TIME1"],";font-size:18px;width:82px")."</td>
		
	</tr>
		<td $stylelegend class=legend>{to_date}:</td>
		<td style='vertical-align:top;font-size:18px'>". field_date("to-date-$t",$_SESSION["SQUID_STATS_DATE2"],";font-size:18px;width:160px",$Selectore)."
		&nbsp;". Field_text("to-time-$t",$_SESSION["SQUID_STATS_TIME2"],";font-size:18px;width:82px")."</td>
	</tr>
	<tr>
		<td $stylelegend class=legend>{members}:</td>
		<td style='vertical-align:top;font-size:18px;'>". Field_array_Hash($members,"members-$t",$_SESSION["SQUID_STATS_MEMBER"],"blur()",null,0,"font-size:18px;")."</td>
	</tr>				
	<tr>
		<td $stylelegend class=legend>{members} {search}:</td>
		<td style='vertical-align:top;font-size:18px;'>". Field_text("members-search-$t","*","font-size:18px;")."</td>
	</tr>	
	<tr>
		<td $stylelegend class=legend>". texttooltip("{categories} {search}","{statistics_categories_explain}").":</td>
		<td style='vertical-align:top;font-size:18px;'>". Field_text("category-search-$t","*","font-size:18px;")."</td>
	</tr>								
	<tr style='height:50px'>	
		<td style='vertical-align:top;font-size:18px;' colspan=2 align='right'>". button("{generate_statistics}","Run$t()",22)."</td>
	</tr>
	</table>
	</div>
<script>
function Run$t(){
	var date1=document.getElementById('from-date-$t').value;
	var time1=document.getElementById('from-time-$t').value;
	var date2=document.getElementById('to-date-$t').value
	var time2=document.getElementById('to-time-$t').value;
	var user=document.getElementById('members-$t').value;
	var interval=document.getElementById('interval-$t').value;
	var searchuser=encodeURIComponent(document.getElementById('members-search-$t').value);
	var categories=encodeURIComponent(document.getElementById('category-search-$t').value);
	Loadjs('$page?query-js=yes&t=$t&container=graph-$t&categories='+categories+'&searchuser='+searchuser+'&date1='+date1+'&time1='+time1+'&date2='+date2+'&time2='+time2+'&interval='+interval+'&user='+user);

}
</script>
";	
	
echo $tpl->_ENGINE_parse_body($html);
	
	
}



function page(){
	$page=CurrentPageName();
	$tpl=new templates();
	$t=time();
	$title=null;
	
	$users=new usersMenus();
	$sock=new sockets();
	
	if(!$users->CORP_LICENSE){
		echo FATAL_ERROR_SHOW_128("{STATS_CATEGORIES_LICENSE}");
		die();
	}
	
	
	
	
	echo "<div style='float:right;margin:5px;margin-top:5px'>".button($tpl->_ENGINE_parse_body("{build_the_query}"), "Loadjs('$page?requeteur-js=yes&t=$t')",16)."</div>";
	$content="<center style='margin:50px' id='websites-button-area'>". button("{build_the_query}","Loadjs('$page?requeteur-js=yes&t=$t')",42)."</center>";
	
	
	if($_GET["zmd5"]==null){
		$q=new mysql_squid_builder();
		$ligne=mysql_fetch_array($q->QUERY_SQL("SELECT title,zmd5 FROM reports_cache WHERE report_type='CATEGORIES' ORDER BY zDate DESC LIMIT 0,1"));
	}else{
		$q=new mysql_squid_builder();
		$ligne=mysql_fetch_array($q->QUERY_SQL("SELECT title,zmd5 FROM reports_cache WHERE zmd5='{$_GET["zmd5"]}'"));
		
	}
	
	
	if($ligne["zmd5"]<>null){
		$nextFunction="LoadAjax('CATEGORIES_STATS_MAIN_GRAPH','$page?main=yes&zmd5={$ligne["zmd5"]}&t=$t');";
		$content=null;
		$title="<div style='font-size:26px;margin-bottom:20px'>".
	texttooltip($tpl->javascript_parse_text($ligne["title"]),
	"{edit}","Loadjs('squid.statistics.edit.report.php?zmd5={$ligne["zmd5"]}&t=$t')").
	"</div>";
	}

	$html="
	<div id='CATEGORIES_STATS_MAIN_GRAPH'>$content</div>
	<script>
		LoadAjaxTiny('stats-requeteur','$page?stats-requeteur=yes&t=$t');
		$nextFunction
	</script>";
	
	
	
echo $tpl->_ENGINE_parse_body($html);
		
}

function main_page(){
	$page=CurrentPageName();
	$tpl=new templates();
	$q=new mysql_squid_builder();
	$zmd5=$_GET["zmd5"];
	$t=time();
	if($zmd5==null){echo "alert('no key sended');UnlockPage();";die();}
	$ligne=mysql_fetch_array($q->QUERY_SQL("SELECT `title` FROM reports_cache WHERE `zmd5`='$zmd5'"));
		$title="
				
	<div style='float:right'>". imgtootltip("refresh32.png","{refresh}","Start$t()")."</div><div style='font-size:26px;margin-bottom:20px'>".
	texttooltip($tpl->javascript_parse_text($ligne["title"]),
	"{edit}","Loadjs('squid.statistics.edit.report.php?zmd5=$zmd5&t=$t')").
	"</div>";
	
	
$html="$title<div style='text-align:left' id='button-$t'></div>

<div style='width:98%' class=form>
	<table style='width:100%'>
			<td width='800px'>		
				<div style='width:800px;height:550px' id='graph3-$zmd5'><center><img src='img/wait_verybig_mini_red.gif'></center></div>
			</td>
			<td style='width:700px;vertical-align:top'>		
				<div  id='table3-$zmd5'><center><img src='img/wait_verybig_mini_red.gif'></center></div>
			</td>
		</tr>	
	</table>
</div>

<div style='width:98%' class=form>
<table style='width:100%'>
	<tr>
		<td width='800px'>		
			<div style='width:800px;height:550px' id='graph4-$zmd5'><center><img src='img/wait_verybig_mini_red.gif'></center></div>
		</td>
		<td style='width:700px;vertical-align:top'>		
			<div  id='table4-$zmd5'><center><img src='img/wait_verybig_mini_red.gif'></center></div>
		</td>
	</tr>	
		
</table>
</div>

<div style='width:98%' class=form>
<table style='width:100%'>

	<tr>
		<td width='800px'>		
			<div style='width:800px;height:550px' id='graph5-$zmd5'><center><img src='img/wait_verybig_mini_red.gif'></center></div>
		</td>
		<td style='width:700px;vertical-align:top'>		
			<div  id='table5-$zmd5'><center><img src='img/wait_verybig_mini_red.gif'></center></div>
		</td>
	</tr>	
		
</table>
</div>

<script>

	function Start$t(){
		LoadAjaxTiny('stats-requeteur','$page?stats-requeteur=yes&t=$t');
		Loadjs('$page?graph3=yes&zmd5=$zmd5');
	}
	
	Start$t();
</script>";	
	
	echo $html;
}


	




function remove_cache_button(){
	$page=CurrentPageName();
	$tpl=new templates();
	$q=new mysql_squid_builder();
	$button_browse=null;
	$button_empty=null;
	$sql="SELECT COUNT(ID) as tcount,report_type FROM `reports_cache` GROUP BY report_type HAVING `report_type`='FLOW'";
	$ligne=mysql_fetch_array($q->QUERY_SQL($sql));
	if(!$q->ok){echo $q->mysql_error_html();}
	
	if(intval($ligne["tcount"])>0){
		$button_browse=$tpl->_ENGINE_parse_body(button("{browse_cache}",
				"Loadjs('squid.statistics.browse-cache.php?report_type=FLOW')",16));
	}
	
	$button_empty=$tpl->_ENGINE_parse_body(button("{empty_cache}","Loadjs('$page?remove-cache-js=yes&zmd5={$_GET["zmd5"]}')",16));
	echo "<table><tr><td nowrap>$button_browse</td><td>&nbsp;</td><td>$button_empty</td></tr></table>";
}

function graph3(){
	$q=new postgres_sql();
	$tpl=new templates();
	$zmd5=$_GET["zmd5"];
	if($zmd5==null){echo "alert('no key sended');UnlockPage();";die();}
	$page=CurrentPageName();
	$time=time();
	$table="{$zmd5}report";
	
	$results=$q->QUERY_SQL("SELECT SUM(rqs) as rqs, category FROM \"$table\" GROUP BY category order by rqs DESC LIMIT 15");
	
	

	
	while($ligne=@pg_fetch_assoc($results)){
		$size=$ligne["rqs"];
		$category=$ligne["category"];
		if($category==null){$category="Unknown";}
		$PieData[$category]=$size;
	}
	
	
	$highcharts=new highcharts();
	$highcharts->container="graph3-$zmd5";
	$highcharts->PieDatas=$PieData;
	$highcharts->ChartType="pie";
	$highcharts->PiePlotTitle="{categories}";
	$highcharts->Title=$tpl->_ENGINE_parse_body("TOP {categories}/{requests}");
	echo $highcharts->BuildChart();
	echo "\n";
	echo "if(!document.getElementById('graph3-$zmd5')){alert('graph3-$zmd5 no such id');}";
	echo "if(document.getElementById('websites-button-area')){document.getElementById('websites-button-area').innerHTML='';}\n";
	echo "LoadAjax('table3-$zmd5','$page?table3=yes&zmd5=$zmd5&t={$_GET["t"]}');\n";
	
}
function graph4(){
	$q=new postgres_sql();
	$tpl=new templates();
	$zmd5=$_GET["zmd5"];
	if($zmd5==null){echo "alert('no key sended');UnlockPage();";die();}
	$page=CurrentPageName();
	$time=time();
	$table="{$zmd5}report";
	
	$results=$q->QUERY_SQL("SELECT SUM(size) as size, category FROM \"$table\" GROUP BY category order by size DESC LIMIT 15");
	
	

	
	while($ligne=@pg_fetch_assoc($results)){
		$size=($ligne["size"]/1024);
		$category=$ligne["category"];
		if($category==null){$category="Unknown";}
		$PieData[$category]=$size;
	}
	
	
	$highcharts=new highcharts();
	$highcharts->container="graph4-$zmd5";
	$highcharts->PieDatas=$PieData;
	$highcharts->ChartType="pie";
	$highcharts->PiePlotTitle="{members}";
	$highcharts->Title=$tpl->_ENGINE_parse_body("TOP {categories}/{size} (KB)");
	echo $highcharts->BuildChart();
	echo "\n";
	echo "if(document.getElementById('websites-button-area')){document.getElementById('websites-button-area').innerHTML='';}\n";
	echo "LoadAjax('table4-$zmd5','$page?table4=yes&zmd5=$zmd5&t={$_GET["t"]}');\n";

}

function graph5(){
	$q=new postgres_sql();
	$tpl=new templates();
	$zmd5=$_GET["zmd5"];
	if($zmd5==null){echo "alert('no key sended');UnlockPage();";die();}
	$page=CurrentPageName();
	$time=time();
	$table="{$zmd5}report";

	$results=$q->QUERY_SQL("SELECT SUM(size) as size, familysite FROM \"$table\" WHERE category='' GROUP BY familysite order by size DESC LIMIT 15");




	while($ligne=@pg_fetch_assoc($results)){
		$size=($ligne["size"]/1024);
		$category=$ligne["familysite"];
		
		$PieData[$category]=$size;
	}


	$highcharts=new highcharts();
	$highcharts->container="graph5-$zmd5";
	$highcharts->PieDatas=$PieData;
	$highcharts->ChartType="pie";
	$highcharts->PiePlotTitle="Unknown";
	$highcharts->Title=$tpl->_ENGINE_parse_body("TOP Unknown {websites}/{size} (KB)");
	echo $highcharts->BuildChart();
	echo "\n";
	echo "if(document.getElementById('websites-button-area')){document.getElementById('websites-button-area').innerHTML='';}\n";
	echo "LoadAjax('table5-$zmd5','$page?table5=yes&zmd5=$zmd5&t={$_GET["t"]}');\n";

}




function table3(){
	$page=CurrentPageName();
	$q=new postgres_sql();
	$tpl=new templates();
	$zmd5=$_GET["zmd5"];
	if($zmd5==null){echo "alert('no key sended');UnlockPage();";die();}
	$table="{$zmd5}report";
	
	$results=$q->QUERY_SQL("SELECT SUM(rqs) as rqs, category FROM \"$table\" GROUP BY category order by rqs DESC LIMIT 15");
	
	$html[]="<table style='width:100%'>";
	$html[]=$tpl->_ENGINE_parse_body("<tr><th style='font-size:18px;padding:8px'>{categories}</td>
			<th style='font-size:18px'>{hits}</th></tr>");

	
	while($ligne=@pg_fetch_assoc($results)){
		$siteENC=urlencode($ligne["category"]);
		
		$href="<a href=\"javascript:blur();\" 
		OnClick=\"javascript:Loadjs('squid.statistics.report.category.php?from-zmd5=$zmd5&USER_DATA=$siteENC');\"
		style='font-size:18px;text-decoration:underline'>";
				
		$site=$ligne["category"];
		if($site==null){$site="unknown";}
		$size=FormatNumber($ligne["rqs"]);
		//$js="Loadjs('squid.statistics.report.member.php?from-zmd5=$zmd5&USER_DATA=".urlencode($site)."');";
		$html[]="<tr><td style='font-size:18px;padding:8px'>$href$site</a></td>
		<td style='font-size:18px'>". FormatNumber($size)."</td></tr>";
	}
		
	$html[]="</table>";
	$html[]="<script>";
	$html[]="Loadjs('$page?graph4=yes&zmd5={$_GET["zmd5"]}&t={$_GET["t"]}')";
	$html[]="</script>";
	echo @implode("", $html);
}


function table4(){
	$page=CurrentPageName();
	$q=new postgres_sql();
	$tpl=new templates();
	$zmd5=$_GET["zmd5"];
	if($zmd5==null){echo "alert('no key sended');UnlockPage();";die();}
	$table="{$zmd5}report";
	
	$sql="SELECT SUM(size) as size, category FROM \"$table\" GROUP BY category order by size DESC LIMIT 15";
	
	if($GLOBALS["VERBOSE"]){echo $sql."<br>\n";}
	$results=$q->QUERY_SQL($sql);
	if(!$q->ok){
		if($GLOBALS["VERBOSE"]){echo $q->mysql_error."<br>\n";}
	}

	$html[]="<table style='width:100%'>";
	$html[]=$tpl->_ENGINE_parse_body("<tr><th style='font-size:18px;padding:8px'>{categories}</td>
			<th style='font-size:18px'>{size}</th></tr>");
	while($ligne=@pg_fetch_assoc($results)){
		$siteENC=urlencode($ligne["category"]);
		$size=FormatBytes($ligne["size"]/1024);
		$site=$ligne["category"];
		if($site==null){$site="unknown";}
		
		$href="<a href=\"javascript:blur();\" OnClick=\"javascript:Loadjs('squid.statistics.report.category.php?from-zmd5=$zmd5&USER_DATA=$siteENC');\"
		style='font-size:18px;text-decoration:underline'>";
		
		//$js="Loadjs('squid.statistics.report.member.php?from-zmd5=$zmd5&USER_DATA=".urlencode($site)."');";
		//$href="<a href=\"javascript:blur();\" OnClick=\"javascript:$js\" style='font-size:18px;text-decoration:underline'>";
		$html[]="<tr><td style='font-size:18px;padding:8px'>$href$site</a></td>
		<td style='font-size:18px'>$size</td></tr>";
	}

	$html[]="</table>";
	$html[]="<script>";
	$html[]="Loadjs('$page?graph5=yes&zmd5={$_GET["zmd5"]}&t={$_GET["t"]}')";
	$html[]="</script>";
	echo @implode("", $html);
}
function table5(){
	$page=CurrentPageName();
	$q=new postgres_sql();
	$tpl=new templates();
	$zmd5=$_GET["zmd5"];
	if($zmd5==null){echo "alert('no key sended');UnlockPage();";die();}
	$table="{$zmd5}report";

	$results=$q->QUERY_SQL("SELECT SUM(size) as size, familysite FROM \"$table\" WHERE category='' GROUP BY familysite order by size DESC LIMIT 15");

	
	
	if(!$q->ok){
		if($GLOBALS["VERBOSE"]){echo $q->mysql_error."<br>\n";}
	}

	$html[]="<table style='width:100%'>";
	$html[]=$tpl->_ENGINE_parse_body("<tr><th style='font-size:18px;padding:8px'>{website}</td>
			<th style='font-size:18px'>{size}</th></tr>");
	while($ligne=@pg_fetch_assoc($results)){
		$size=FormatBytes($ligne["size"]/1024);
		$site=$ligne["familysite"];
		if($site==null){$site="unknown";}
		//$js="Loadjs('squid.statistics.report.member.php?from-zmd5=$zmd5&USER_DATA=".urlencode($site)."');";
		//$href="<a href=\"javascript:blur();\" OnClick=\"javascript:$js\" style='font-size:18px;text-decoration:underline'>";
		$html[]="<tr><td style='font-size:18px;padding:8px'>$href$site</a></td>
		<td style='font-size:18px'>$size</td></tr>";
	}

	$html[]="</table>";
	$html[]="<script>";
	//$html[]="Loadjs('$page?graph5=yes&zmd5={$_GET["zmd5"]}&t={$_GET["t"]}')";
	$html[]="</script>";
	echo @implode("", $html);
}
function FormatNumber($number, $decimals = 0, $thousand_separator = '&nbsp;', $decimal_point = '.'){$tmp1 = round((float) $number, $decimals); while (($tmp2 = preg_replace('/(\d+)(\d\d\d)/', '\1 \2', $tmp1)) != $tmp1)$tmp1 = $tmp2; return strtr($tmp1, array(' ' => $thousand_separator, '.' => $decimal_point));}