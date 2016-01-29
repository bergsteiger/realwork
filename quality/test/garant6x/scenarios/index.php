<HTML>

  <HEAD>
    <META  http-equiv=Content-Type content="text/html; charset=windows-1251">

    <SCRIPT>
    	 complect = 'TestBase';
    </SCRIPT>

  </HEAD>

 	<BODY>

  	<INPUT type="radio" name="kibselect" onclick="complect='SuperMaximum';">СуперМаксимум<BR>
    <INPUT type="radio" name="kibselect" onclick="complect='TestBase';" checked>Тестовая база<BR>

    <?
			//---------------------------------------------------------------------------------------------------------------
		  function GetScenarioDescription($fileName)
		  {
		  	$htmlarray = file($fileName);
	    	foreach($htmlarray as $n=>$row)
	    	{
	    		$pos = strpos($row, "СЦЕНАРИЙ");
	    		if (is_integer($pos))
	    		{
	    			$pos2 = strpos($row, ".", $pos);
		    		if (is_integer($pos2))
		    		{
		    		  $result = substr($row, $pos2+2);
		    			return $result;
		    		}
	    		}
	    	}
		  }

      //---------------------------------------------------------------------------------------------------------------
      //BEGIN OF PHP MAIN TEXT
    	$path = ".\\ts\\";
    	$htmlarray = file($path."ts000.txt");
    	foreach($htmlarray as $n=>$row)
    	{
    	  $fileName = $path."ts".trim($row).".txt";
    		echo $row.". ";
    		echo "<a href=\"http://asingle05/hltcparser.php?filename=".$fileName."\" onclick=\"document.location=href+'&kib='+complect;return false;\">";
    		echo GetScenarioDescription($fileName);
    		echo "</a><BR>";
    	}
    ?>
	</BODY>

</HTML>