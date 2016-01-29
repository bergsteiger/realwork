<HTML><BODY><META  http-equiv=Content-Type content="text/html; charset=windows-1251">
<?
/////////////////////////////////////////////////////////////////////////////////////////////////////
// ����������� �����������
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
	function AddTrace($str, $add)
	{
	  if ($add!="")
	  {
	  	if ($str!="")
	  	{
	  	  $pos = strpos($str, ".".$add.".");                          	
	   	  if (!is_integer($pos))                                      
	   	  {                                                           
	   	  	for($i=0,$pos=0,$pos2=0;is_integer($pos);$i++)            
	   	  	{                                                         
	   	  		$pos2 = strpos($str,".",$pos+1);                        
	   	  		if (is_integer($pos2))                                  
	   	  		{                                                       
	   	  			$txt = substr($str, $pos+1, $pos2-$pos-1);            
	   	  			$content[$i]=$txt;                                    
	   	  		}                                                       
	   	  		$pos=$pos2;                                             
	   	  	}                                                         
	   	  	$contents_count = $i / 2;                                 
	   	  	$str="";                                                  
	                                                                   
	   	  	if ($add < $content[0])                                   
	   	  	{                                                         
	   		  		$str=$str.".".$add.".";                               
	   	  	}                                                         
	   		  for ($i=0;$i<$contents_count-1;$i++)                      
	   		  {                                                         
	   		  	if ( ($add>$content[$i*2]) && ($add<$content[$i*2+2]) ) 
	   		  	{                                                       
	   		  		$str=$str.".".$content[$i*2]."..".$add.".";           
	   		  	}                                                       
	   		  	else                                                    
	   		  	{                                                       
	   		  		$str=$str.".".$content[$i*2].".";                     
	   		  	}                                                       
	   		  }                                                         
	   	 		$str=$str.".".$content[$contents_count*2-2].".";          
	   	  	if ($add > $content[$contents_count*2-2])                 
	   	  	{                                                         
	   		  		$str=$str.".".$add.".";                               
	   	  	}                                                         
	  		}
	  	}
	  	else
	  	{
	  		$str=".".$add.".";
	  	}
	  }
	  return $str;
	}

//===================================================================================================
	function DeleteTrace($str, $add)
	{
	  $pos = strpos($str, ".".$add.".");
	  if (is_integer($pos)) 
	  {
	  	$str = str_replace(".".$add.".", "", $str);
	  }
	  return $str;
	}

//===================================================================================================
//BEGIN OF THE PROGRAM IS HERE
	
	//���������� ���� �� ������� ���������� � ������ $hltc - �������� ���������� � $value - ������ ����������
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
			$hltc[$i]=GetValueFromCsvStr($normalized_row, 1);
			$value[$i]=GetValueFromCsvStr($normalized_row, 2);
			$hltctrace[$i]="";
			$i++;
		}
	}
	$hltc_count=$i-1;

	//��������� ���� �� ������� ������� ���������, ���������� �� ���� ����� ������ ���������
 	$path = ".\\ts\\";
 	$htmlarray = file($path."ts000.txt");
	$i=0;
	foreach($htmlarray as $n=>$row)
	{
		//��������� ����� ��������
		$testscenarioID = intval($row);
		if (trim($row)!="")
		{
		  $filename = $path."ts".trim($row).".txt";
			$scenario = file($filename);

    //C�������� ��������� ���������� � �������� �����������
    	echo $filename."<BR>";
			//������� ��� ����������� � ������� ��������
			for ($i=0;$i<$hltc_count;$i++)
			{
				$hltctrace[$i] = DeleteTrace($hltctrace[$i], $testscenarioID);
			}

			//����������� �����������
			foreach($scenario as $k=>$str)
			{
				$t1 = GetHLTC($str,"<",">");
				$t2 = GetHLTC($str,"[","]");
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
					for ($i=0;$i<$hltc_count;$i++)
					{
						if (  ($hltc[$i]==$t) || ( ($t1!="") &&	is_integer(strpos($hltc[$i], $t.".")) )  )
						{
							$hltctrace[$i] = AddTrace($hltctrace[$i], $testscenarioID);
						}
					}
				}
			}
		}

	}

	//���������� ����� ������������ � ����
	$outfile=fopen("traces.csv","w+");
	for ($i=0;$i<$hltc_count;$i++)
	{
		fwrite($outfile, "\"".$hltc[$i]."\",\"".$hltctrace[$i]."\"\n");
	}
	fclose($outfile);

?>

</BODY></HTML>