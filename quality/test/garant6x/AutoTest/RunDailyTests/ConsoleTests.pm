package ConsoleTests;
use Win32;
use Common;
use Average;

use strict;
use Getopt::Std;

sub test {	
	my ($config) = @_;
	my $PATH_SETTINGS = $config->{"MAIN"}->{"BUILD_PATH"} . "\\server\\settings";
	print "$PATH_SETTINGS\n";
}

sub run {
	print "Run ConsoleTests";	
	my ($config) = @_;
	
	my $PATH_SETTINGS = $config->{"MAIN"}->{"BUILD_PATH"} . "\\server\\settings";
	
	my $OS_VER;
	if (Win32::IsWin95) {
		$OS_VER = "Win9x";
	} elsif (Win32::IsWinNT) {
		$OS_VER = "Winnt";
	}
	
	print "Останавливаем сервер";
	
	qx ($config->{"MAIN"}->{"PS_TOOLS_PATH"}\\psservice.exe $config->{"MAIN"}->{"SERVER_HOST"} -u qc -p "22222" stop GarantF1Server);
	sleep 10;
	
	Common::update_server ($config);
	
	print "Копируем утилиту";
	
	qx (xcopy "$config->{"MAIN"}->{"BUILD_PATH"}\\support\\test\\client\\$OS_VER\\timetest.exe" "$config->{"MAIN"}->{"SERVER_PATH"}\\apps\\$OS_VER" /y/e);

	my $result_file = $config->{"CONSOLE_TESTS"}->{"RESULT_FILE"};
    
    print "считываем текущий тэг";
    my $cvs_tag_file = $config->{"MAIN"}->{"BUILD_PATH"}. "/!cvs_tag";
	open (CVS_TAG, "<$cvs_tag_file");
	my @cvs_tag = <CVS_TAG>; 
    close (CVS_TAG);
    
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = Common::get_date_time ();
    
    my $date = $mday. ".".$mon . ".". $year;
    my $time = $hour. ":".$min . ":". $sec;
    
   	my $execute_count = $config->{"CONSOLE_TESTS"}->{"EXECUTE_COUNT"};
   	
    Common::add_line_to_file ($result_file, "***************Start ${execute_count} tests (${date}::${time})****************");
    Common::add_line_to_file ($result_file, @cvs_tag);
 	
 	print "выполняем в цикле тесты";
 	for (my $i = 1; $i <= $execute_count; $i++) {
 		print "Итерация: $i";
 		Common::reboot_server ($config);
 		qx ($config->{"MAIN"}->{"PS_TOOLS_PATH"}\\psservice.exe $config->{"MAIN"}->{"SERVER_HOST"} -u qc -p "22222" stop GarantF1Server);
		sleep 20;
		
		Common::get_clean_settings ($config);
		qx ($config->{"MAIN"}->{"PS_TOOLS_PATH"}\\psservice.exe $config->{"MAIN"}->{"SERVER_HOST"} -u qc -p "22222" start GarantF1Server);
		sleep 30;
		
		# пока используем досявые команды...
		
		qx (if NOT exist "$config->{"MAIN"}->{"SERVER_PATH"}\\reports" mkdir "$config->{"MAIN"}{"SERVER_PATH"}\\reports");
		qx (if NOT exist "$config->{"MAIN"}->{"SERVER_PATH"}\\reports\\$date" mkdir "$config->{"MAIN"}->{"SERVER_PATH"}\\reports\\$date");
 		
 		my $log_file = $config->{"MAIN"}->{"SERVER_PATH"} . "\\reports\\$date\\result_" .$i . ".log";
 		qx (
	 		$config->{"MAIN"}->{"SERVER_PATH"}\\apps\\$OS_VER\\timetest.exe -log $log_file -result_file $result_file
 		);
 		 		
 	}
 	Average::average ($result_file);
 	
 	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = Common::get_date_time ();    
    $date = $mday. ".".$mon . ".". $year;
    $time = $hour. ":".$min . ":". $sec;
 	
 	Common::add_line_to_file ($result_file, "***************End ${execute_count} tests (${date}::${time}) ****************");
 	
 	print "отправляем почту";
 	my $mail_to = $config->{"MAIN"}->{"MAIL_TO"};
  	my $reply_to = $mail_to;
  	my $mail_form = $config->{"MAIN"}->{"MAIL_FROM"};
	my $smtp_server = $config->{"MAIN"}->{"SMTP_SRV"};
 	qx ($config->{"MAIN"}->{"BLAT_PATH"}\\blat.exe -install "$smtp_server" "$mail_form"); 	
 	qx ($config->{"MAIN"}->{"BLAT_PATH"}\\blat.exe "$result_file" -subject "AutoTest: Result of time test" -to "$mail_to");
 	
}

1;