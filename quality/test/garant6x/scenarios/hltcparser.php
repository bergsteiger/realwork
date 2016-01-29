<HTML><BODY><META  http-equiv=Content-Type content="text/html; charset=windows-1251"><FONT SIZE="2pt">
<?
/////////////////////////////////////////////////////////////////////////////////////////////////////
// Вьювер
/////////////////////////////////////////////////////////////////////////////////////////////////////
//===================================================================================================
  function GetValueFromCsvStr($str, $index)
  {
		$pos=0;
		$pos2=0;
		$result="";
		for ($i=1;$i<=$index;$i++)
		{
			$result="";
			if ($str[$pos]=="\"")
			{
				$pos2 = strpos($str, "\"", $pos+1);
				if (is_integer($pos2)) 
				{
					if ($i==$index)
					{
						$result=substr($str, $pos+1, $pos2-$pos-1);
						break;
					}
					else
					{
						$pos = $pos2+2;
					}
				}
			}
			else
			{
				$pos2 = strpos($str, ",", $pos);
				if (is_integer($pos2)) 
				{
					if ($i==$index)
					{
						$result=substr($str, $pos, $pos2-$pos);
						break;
					}
					else
					{
						$pos = $pos2+1;
					}
				}
				else
				{
					if ($i==$index)
					{
						$result=substr($str, $pos);
					}
					break;
				}
			}
		}
		return $result;
	}
//===================================================================================================
	function GetCountOfSubStr($str, $substr)
	{
		for($i=-1,$pos=-1; is_integer($pos);$i++)
		{
			$pos = strpos($str, $substr, $pos+1);			
		}
		return $i;
	}

//===================================================================================================
	function GetHLTC($str, $format_begin, $format_end)
	{
		$result="";
		$pos=strpos($str, $format_begin."HLTC");
		if (is_integer($pos)) 
		{
			$pos2=strpos($str, $format_end, $pos);
			if (is_integer($pos2)) $result=substr($str, $pos+1, $pos2-$pos-1);
		}
		return $result;
	}

//===================================================================================================
	function GetPrevHLTC($str)
	{
		$result="";
		$pos=strpos($str, "HLTC");
		if (is_integer($pos)) 
		{
			$result=substr($str,0, $pos-1);
		}
		return $result;
	}

//===================================================================================================
//BEGIN OF THE PROGRAM IS HERE
	$htmlarray=file("hltc.csv");
	
	$requestedKIB = strtolower($_REQUEST['kib']);
	$i=0;
	foreach($htmlarray as $n=>$row)
	{
	  //расставляем кавычки в 
		$normalized_row = str_replace("\"\"", "'", $row);
		$normalized_row = str_replace(",',", ",\"\",", $normalized_row);
		$normalized_row = str_replace(",',", ",\"\",", $normalized_row);
		$normalized_row = str_replace(",'\r", ",\"\"\r", $normalized_row);
		$passedfailed = strtolower(GetValueFromCsvStr($normalized_row, 5));
		$kib = strtolower(GetValueFromCsvStr($normalized_row, 8));
	  if (($passedfailed!="inactive") && ($passedfailed!="transfered") && (($kib=="") || ($kib==$requestedKIB)) )
	  {
			$tag[$i]=GetValueFromCsvStr($normalized_row, 1);
			$value[$i]=GetValueFromCsvStr($normalized_row, 2);
			$i++;
		}
	}
	$tags_count=$i-1;

	$testscenario = file($_REQUEST['filename']);
	$testcasecount = 0;
	foreach($testscenario as $n=>$row)
	{
		$t1 = GetHLTC($row,"<",">");
		$t2 = GetHLTC($row,"[","]");
		if ($t1=="")
		{
			$t=$t2;
		}
		else
		{
			$t=$t1;
		}

		if ($t!="") 
		{
			for ($i=0;$i<$tags_count;$i++)
			{
				if (  ($tag[$i]==$t) || ( ($t1!="") &&	is_integer(strpos($tag[$i], $t.".")) )  )
				{
					$testcasecount++;
					$prev = GetPrevHLTC($row);
					$tabs = GetCountOfSubStr($prev, "->");
					$leave = substr($tag[$i], strlen($t));
					$points = GetCountOfSubStr($leave, ".");

					$first = "<DIV style=\"margin-left:".(20*($tabs+$points))."pt\"><IMG SRC=\"img/passed.gif\" border=0>&nbsp;";
					$first = $first."<B>".str_replace("->","",GetPrevHLTC($row))."</B>";
					$first = $first.$tag[$i].".&nbsp;".$value[$i]."</DIV>";
					echo $first;
				}
			}
		}
		else
		{
			$tabs = GetCountOfSubStr($row, "->");
			if ($tabs>0)
			{
				echo "<DIV style=\"margin-left:".(20*$tabs)."pt\"><B>".str_replace("->","",$row)."</B><BR></DIV>";
			}
			else
			{
				echo "<B>".$row."</B><BR>";
			}
		}
	}
?>
</FONT></BODY></HTML>