<?php
    include 'DAO.php'; 
    if (!$_GET["section"]) {
	$_GET["section"]="home";
    }
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

    <head>
	<title>LinuxAP-eh</title>
	<meta name="author" content="Lluis Vilanova" >
	<meta name="generator" content="vim 6.3.13" >
	<meta name="description" content="Homepage for the LinuxAP-eh and OpenWRT-eh projects" >
	<meta name="keywords" content="LinuxAP LinuxAP-eh linuxap linuxap-eh OpenWRT OpenWRT-eh EnHanced enhanced openwrt openwrt-eh wireless linux access point ap AP" >
	<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" >
	<meta http-equiv="Content-Script-Type" content="text/javascript" >
	<meta http-equiv="Content-Style-Type" content="text/css" >
	<link rel="stylesheet" type="text/css" href="./linuxAP-eh.css" >
    </head>

    <body>
	<table cellspacing=30>
	    <tfoot>
	        <tr>
		    <td> </td>
		    <td> <table if="footer">
<!-- START FOOTER -->
<?php
    include("./footer.html");
?>
<!-- END FOOTER -->
		    </table> </td>
		</tr>
	    </tfoot>
	    <tbody>
		<tr>
<!-- START HEADER -->
		    <td id="logo"><img src="./Images/logo.png" alt="linuxAP-eh"></td>
		    <td id="title"><img src='Images/<?=$_GET["section"]?>-ligth.png' alt='<?=$_GET["section"]?>'></td>
<!-- START HEADER -->
		</tr>
		<tr>
		    <td>
			<table>
			    <tbody id="menu">
<!-- START MENU -->
<?php 
    $menu = getMenu();
    foreach ($menu as $item) {
	include ("menuitem.php");
    }
?>
<!-- END MENU -->
			    </tbody>
			</table>
		    </td>
		    <td id="contents">
<!-- START CONTENTS -->
<?php
    include("./Contents/" . $_GET["section"] . ".php");
?>
<!-- END CONTENTS -->
		    </td>
		</tr>
	    </tbody>
	</table>
    </body>

</html>
