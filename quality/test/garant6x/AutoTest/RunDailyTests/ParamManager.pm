package ParamManager;

#функция считывает конфигурационный файл в ini формате в хэш
# возвращает ссылку на хэш 
sub load_config 
{     
    local ($fconfig) = @_; 
    open(FH, "<$fconfig") || die "Can't open file $fconfig"; 
        flock(FH,2); 
        my @config = <FH>; 
    close(FH); 
 
    my $cfg_hash = {}; 
 
    my ($section, $tmpl_section); 
    my $tmpl_flag = 0; 
    foreach my $item (@config) 
    { 
           if ($item =~ /^TMPL\>\>/) # проверяем окончание шаблона 
           { 
                    $tmpl_flag = 0; 
                    next; 
           } 
           if ($tmpl_flag == 1) # добавляем строку в сущность если это шаблон 
           { 
                   $cfg_hash->{$section}->{$tmpl_section} .= $item; 
                   next; 
           } 
           next if $item =~ /^[\n|#]/; 
           $item =~ s/\n+//g; 
           if ($item =~ /^\[(.*)\]$/) 
           { 
                  $cfg_hash->{$1} = {};
                  $section = $1;
           }
           elsif ($item =~ /([^\=]+)\=\<\<TMPL/) # проверяем начало шаблона
           {
                  $tmpl_section = $1;
                  $cfg_hash->{$section}->{$tmpl_section} = "";
                  $tmpl_flag = 1;
           } 
           else
           {
                 my ($key,$value) = $item =~ /([^\=]+)\=([^\=]+)/;
                 $cfg_hash->{$section}->{$key} = $value;
           }
    }
    return $cfg_hash;
}

#Читаем содержимое ini файла и записываем в хэш
#В ini файле различаем только серкии [SECTION]
#  комментарии # и паные параметры А=B
sub get_ini_hash {
	local ($iniFile) = @_;
  open(FH, "<$iniFile") || die "Can't open file $iniFile";
      flock(FH,2);
      my @iniArray = <FH>;
  close(FH);
	my %iniHash;
	$section_name = '';
	foreach my $i (@iniArray) {
		if ( $i =~ /^\[(.*)\]$/ ) {
			$section_name = $1;
			#print "$section_name\n";
		}
		if ( $i =~ /^(.*)\=(.*)$/ ) {
			#print "$1 , $2\n";
			my $tmp = $section_name;
			#print "SECTION: $section_name\n";
			if ($section_name ne "") {
				#print "bingo";
				${$iniHash{$section_name}}{$1} = $2;
				#print "iniHash[section_name][1]: $iniHash{$section_name}{$1}\n";
			}
			
		}
	}
  return %iniHash;
  #Распечатка содержимого хэша
	#foreach $section (keys %iniHash) {
	#	print "SECTION: $section SECTION_HASH: %{$iniHash{$section}}\n";
	#	foreach $param_key (keys %{$iniHash{$section}}) {
	#		print "KEY: $param_key = VALUE: ${$iniHash{$section}}{$param_key}\n";
	#	}
	#}


}


1;