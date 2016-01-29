package Common;

use strict;

#функция добавляет строку к файлу
sub add_line_to_file {
	my ($file_name, $text) = @_;
	open (FH, ">>$file_name") || die "Can't open file $file_name";
	print FH "$text\n";	
	close (FH);
}

sub get_date_time{
        my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
        $mon++;
        $year += 1900;
				if ($mon < 10 ){
					$mon = "0". $mon;
				}
				if ($mday < 10 ){
					$mday = "0". $mday;
				}				
        return ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
}

#обновляем файлы сервера
sub update_server {
	my ($config) = @_;
	qx (if exist "$config->{"MAIN"}->{"SERVER_PATH"}\\apps" del /q /f /s "$config->{"MAIN"}->{"SERVER_PATH"}\\apps");
	qx (xcopy "$config->{"MAIN"}->{"BUILD_PATH"}\\server\\apps"   "$config->{"MAIN"}->{"SERVER_PATH"}\\apps" /y/e);
	qx (xcopy "$config->{"MAIN"}->{"BUILD_PATH"}\\..\\..\\.current\\other\\tcclients.dll"   "$config->{"MAIN"}->{"SERVER_PATH"}\\apps" /y/e);
}

#перегружаем машину, на которой работает сервер
sub reboot_server {
	my ($config) = @_;
	my $FLAG_REBOOT=$config->{"MAIN"}->{"SERVER_PATH"}. "\\reboot.flag";

	add_line_to_file ($FLAG_REBOOT, "reboot flag");

	qx ($config->{"MAIN"}->{"PS_TOOLS_PATH"}\\psshutdown.exe $config->{"MAIN"}->{"SERVER_HOST"} -u qc -p "22222" -r -t 1);

	#пока не пропал файл, сервер не перегрузился - ждём
	while (-e "$FLAG_REBOOT") {
		sleep 10;
	}
	while (!(-e "$FLAG_REBOOT")) {
		sleep 10;
	}
	
	sleep 30;
}

#копируем чистые настройки
sub get_clean_settings {
	my ($config) = @_;
	my $PATH_SETTINGS = $config->{"MAIN"}->{"BUILD_PATH"} . "\\server\\settings";
	
	print "$PATH_SETTINGS\n";
	
	qx (if exist "$config->{"MAIN"}->{"SERVER_PATH"}\\settings" rmdir /q/s "$config->{"MAIN"}->{"SERVER_PATH"}\\settings");
	qx (if not exist "$config->{"MAIN"}->{"SERVER_PATH"}\\settings" mkdir "$config->{"MAIN"}->{"SERVER_PATH"}\\settings");
	qx (xcopy $PATH_SETTINGS   "$config->{"MAIN"}->{"SERVER_PATH"}\\settings" /y/e);
}

#функция ищет в файле заданную строку, если есть возвращает 1, иначе 0
sub find_string_in_file {
	my ($file_name, $string) = @_;
	open (FH, "<$file_name");
	my @file_content = <FH>;
	close (FH);
	my $result = 0;
	foreach my $item (@file_content ) {
		if (!($item =~ /$string/)) {
			$result = 1;
			last;
		}
	}
	
	return $result;
}

sub get_processes {	
	my (%counter, %r_counter, %process_by_name);	
	    Win32::PerfLib::GetCounterNames('', \%counter);	
	    %r_counter = reverse %counter;	
	my $process_obj = $r_counter{'Process'};	
	my $process_id = $r_counter{'ID Process'};	
	my $perflib = new Win32::PerfLib('');	
	    my $proc_ref = {};	
	    $perflib->GetObjectList($process_obj, $proc_ref);	
	    $perflib->Close();	
	    my $instance_ref = $proc_ref->{'Objects'}->{$process_obj}->{'Instances'};	
	    foreach my $instance (values %{$instance_ref})	
	    {	
	        my $counter_ref = $instance->{'Counters'};	
	        foreach my $counter (values %{$counter_ref})	
	        {	
	            if($counter->{'CounterNameTitleIndex'} == $process_id)	
	            {	
	                push @{$process_by_name{$instance->{'Name'}}}, $counter->{'Counter'};	
	            }	
	        }	
	    }	
	return %process_by_name;	
}

#функция делает скриншот экрана
sub make_snap {
	my ($config) = @_;
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = get_date_time ();
    
    my $date = $mday. ".".$mon . ".". $year;
    my $time = $hour. "-".$min . "-". $sec;

	my $file_name =$date . $time;
	qx (
		$config->{"PERFOMANCE_TESTS"}->{"HYSNAPDX_PATH"} 
		-hidden -initfrom:$config->{"PERFOMANCE_TESTS"}->{"SNAPS_INI"} 
		-QuickSave,1000,1,1 -snap 
		-save:jpg $config->{"PERFOMANCE_TESTS"}->{"SNAPS_DIR"}\\$file_name);
}



#функция ищет процесс, если находит - "убивает" его
sub find_kill {
	my ($process_name, $config) = @_;
	my $out_file = $config->{"PERFOMANCE_TESTS"}->{"OUT_FILE"};
	my $log_dir = $config->{"PERFOMANCE_TESTS"}->{"LOG_DIR"};
	my $string = "was not found";
	my %process_by_name = get_processes ();
	if (defined ($process_by_name{$process_name})) {
		make_snap ($config);
		kill ('SIGKILL', $process_by_name{$process_name}[0]);
		my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = get_date_time ();
      	my $date = $mday. ".".$mon . ".". $year;
      	add_line_to_file ($config->{"PERFOMANCE_TESTS"}->{"LOG_DIR"}. "\\" . $date . ".log", "$process_name was FOUND and KILLED");
	}
}

sub prepare_tests_hash {
	my @tests_arr = @_;
	my %tests = ();
	for my $item (@tests_arr) {
		if ($item =~ /(.*)\|(\d+)/) {
			$tests{$1} = $2;
		}
	}
	
	return %tests;
}




1;