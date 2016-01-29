package GUI_Perfomance_Tests;

use Common;
use Average;
use strict;

sub test {
	print "GUI_Perfomance_Tests\n";
}

sub run {
	my ($config) = @_;
	qx ($config->{"MAIN"}->{"PS_TOOLS_PATH"}\\psservice.exe $config->{"MAIN"}->{"SERVER_HOST"} -u qc -p "22222" stop GarantF1Server);
	sleep 40;
	Common::get_clean_settings ($config);
	sleep 5;
	qx ($config->{"MAIN"}->{"PS_TOOLS_PATH"}\\psservice.exe $config->{"MAIN"}->{"SERVER_HOST"} -u qc -p "22222" start GarantF1Server);
	
	my $tc = $config->{"MAIN"}->{"TC_PATH"};
	my $tc_proj = $config->{"MAIN"}->{"TC_PROJECT_PATH"};
	Common::find_kill ("TestComplete", $config);
	qx ($tc /RunAndExit $tc_proj. "\\Prepare_GUI_Shell.mds" gui_login=perf gui_password=perf);
	Common::find_kill ("drwtsn32", $config);
	Common::find_kill ("f1shell", $config);
	
	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = Common::get_date_time ();
	my $date = $year. ".".$mon . ".".$mday;
    
	my $count_execute = $config->{"PERFOMANCE_TESTS"}->{"EXECUTE_COUNT"};
	my @tests_arr = split /;/, $config->{"PERFOMANCE_TESTS"}->{"TESTS"};
	my %tests = Common::prepare_tests_hash ($config);
	
  	foreach my $curr_test (%tests) {
  		print "Start test \[$curr_test\]";
	    for (my $i = 1; $i <= $count_execute; $i++) {
	    	Common::reboot_server ($config);
			Common::find_kill ("TestComplete", $config);
	    	qx (
	    	 	$tc /RunAndExit $tc_proj. "\\GUI_Perfomance.mds" perf_op=$curr_test max_itr=$tests{$curr_test} log_dir=$config->{"PERFOMANCE_TESTS"}->{"LOG_DIR"} curr_date = $date}
	    	);
	    	Common::find_kill ("drwtsn32", $config);
	    	Common::find_kill ("f1shell", $config);
	    }
 	}
	my $mLogFile = $config->{"PERFOMANCE_TESTS"}->{"LOG_DIR"} . "\\" . $date . ".log";
	Average::MakeFinalReport ($mLogFile);
	my $mail_to = $config->{"MAIN"}->{"MAIL_TO"};
  	my $reply_to = $mail_to;
  	my $mail_form = $config->{"MAIN"}->{"MAIL_FROM"};
	my $smtp_server = $config->{"MAIN"}->{"SMTP_SRV"};
	
 	qx ($config->{"MAIN"}->{"BLAT_PATH"}\\blat -install "$smtp_server" "$mail_form");
 	qx ($config->{"MAIN"}->{"BLAT_PATH"}\\blat "$mLogFile" -subject "AutoTest: Result of GUI Perfomance test" -to "$mail_to");	
}

1;