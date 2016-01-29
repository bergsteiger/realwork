<HTML><BODY><META  http-equiv=Content-Type content="text/html; charset=windows-1251">
<?
/////////////////////////////////////////////////////////////////////////////////////////////////////
// Создание списка неохваченных сценариями тесткейсов
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
//BEGIN OF THE PROGRAM IS HERE
	
	//Зачитываем файл со списком тесткейсов в массив $tag - названия тесткейсов и $value - тексты тесткейсов
	$htmlarray=file("hltc.csv");
	$i=0;
	foreach($htmlarray as $n=>$row)
	{
		$normalized_row = str_replace(",\"\"", ",\" \"", $row);
		$normalized_row = str_replace("\"\"", "'", $normalized_row);
		$normalized_row = str_replace("\",", "\",\"", $normalized_row);
		$normalized_row = str_replace(",\"", "\",\"", $normalized_row);
		$normalized_row = str_replace("\"\"", "\"", $normalized_row);
		$normalized_row = str_replace("\" \"", "\"\"", $normalized_row);

		$passedfailed = strtolower(GetValueFromCsvStr($normalized_row, 5));
	  if (($passedfailed!="inactive") && ($passedfailed!="transfered"))
	  {
			$tag[$i]=GetValueFromCsvStr($normalized_row, 1);
			$value[$i]=GetValueFromCsvStr($normalized_row, 2);
			$level[$i]=GetValueFromCsvStr($normalized_row, 4);
			$rating[$i]=trim(GetValueFromCsvStr($normalized_row, 7));
			$i++;
		}
	}
	$tags_count=$i-1;

	
	//Зачитываем файл трассировок и апдейтим его новыми.
	$htmlarray=file("traces.csv");
	$i=0;
	foreach($htmlarray as $n=>$row)
	{
		$hltc[$i]=GetValueFromCsvStr($row, 1);
		$val[$i]=GetValueFromCsvStr($row, 2);
		$i++;
	}
	$hltc_count=$i-1;


	$mode = $_REQUEST['mode'];
	$filter = trim($_REQUEST['filter']);
	if ($mode=="csv")
	{
		//Создаем файл неохваченных тесткейсов
		$outfile=fopen("last.csv","w+");
		for ($i=0;$i<$tags_count;$i++)
		{
		  for ($j=0; $j<$hltc_count; $j++)
		  {
	  		if ($tag[$i]==$hltc[$j])
	  		{
		  		if ($val[$j]=="")
		  		{
						fwrite($outfile, "\"".$tag[$i]."\",\"".$value[$i]."\",\"".$level[$i]."\"\n");
					}
					break;
				}
			}
		}
		fclose($outfile);
		echo "См. файл last.csv<BR>";
	}
	else
	{
		$last_count = 0;
		for ($i=0;$i<$tags_count;$i++)
		{
		  for ($j=0; $j<$hltc_count; $j++)
		  {
	  		if ($tag[$i]==$hltc[$j])
	  		{
		  		if ($val[$j]=="")
		  		{
					$filterlevel = substr($level[$i], 0, 1);

					if ($filterlevel=="")
					{
  						$color="#00FFFF";
						$last_count++;
					}
					else
					{
						if ($filterlevel==0) 
						{
		  					$color="#C0C0C0";
						}
			  			else
						{
							if ($filterlevel==1)
			  					$color="#FF00000";
				  			elseif ($filterlevel==2) 
			  					$color="#00FF00";
							elseif ($filterlevel==3) 
					  			$color="#0000FF";
					  		elseif ($filterlevel==4)
			  					$color="#000000";
							$last_count++;
						}
					}
		  			if (($filter==0) || ($filter==$filterlevel))
		  			{
						echo "<FONT COLOR=".$color.">".$tag[$i].".".$value[$i].".".$level[$i]."</FONT><BR>";
					}
				}
				break;
			}
		}
	}
	echo "<BR><B><FONT COLOR=#808080>Не задействовано ".$last_count." тесткейсов</FONT></B><BR>";
  }
?>

</BODY></HTML>