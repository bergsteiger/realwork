use time::local;
use Tk;
use Getopt::Std;
use File::Copy;

#ищем строчку в файле
#file_name - файл, в котором осуществляется поиск
#str - искомый текст
#reverse - поиск с конца файла
#результат работы функции строчка полная строка файла, где найдена первая искомая строка
sub find_string {
	my $file_name = shift;
	my $str = shift;
	my $revers = shift;	
	print "Start searching [$str] in file $file_name\n";
	open(FH, "<$file_name") || die "Can't open file $file_name"; 
	flock(FH,2);
	my @file_data = <FH>;	
	close(FH); 
	my $result = undef;
	if ($revers) {
		print "revers searching\n";		
		for (my $i = $#file_data; $i > 0; $i--) {
			if ($file_data[$i] =~  /$str/) {
    		$result = $file_data[$i];
    		last;
    	}
		}
	} else {		
		for (my $i = 0; $i < @file_data; $i++) {
			if ($file_data[$i] =~  /$str/) {
    		$result = $file_data[$i];
    		last;
    	}
		}
	}	
	return $result;
}

sub extract_date {
	my $str = shift;
	$str =~ s/  / /;
	my @array = split / /, $str;
	my %month_map;
	$month_map{"Jan"} = 1;
	$month_map{"Feb"} = 2;
	$month_map{"Mar"} = 3;
	$month_map{"Apr"} = 4;
	$month_map{"May"} = 5;
	$month_map{"Jun"} = 6;
	$month_map{"Jul"} = 7;
	$month_map{"Aug"} = 8;
	$month_map{"Sen"} = 9;
	$month_map{"Oct"} = 10;
	$month_map{"Nov"} = 11;
	$month_map{"Dec"} = 12;	
	return "$array[2]/$month_map{$array[1]}/$array[3]";
}

our ($opt_f, $opt_s);
getopts ('f:s:');

if (defined($opt_f) && defined($opt_s)) {
	my $file = $opt_f;
	my $str = $opt_s;
	
	print "Start searching string [$str] in file [$file]\n";
	my $time = time();
	my ($mday,$mon,$year) = (localtime($time))[3..5];
	$mon++;
	$year+=1900;
	
	open(FILE, "<$file") || die "Can't open file $file_name"; 
	my @lines = <FILE>;
	close(FILE);
	my @results = grep { /$str/ } @lines;
	
	my $current_date = "$mday/$mon/$year";
	my $last_log_str = $results[$#results];
	my $log_date = extract_date($last_log_str);
	
	print "Current date: $current_date\n";		
	print "Log date: $log_date\n";
	if ($current_date eq $log_date) {
		print "String found: $last_log_str\n";
		my $blat_dir = "$ENV{BLAT_PATH}";
		my $mail_to = "$ENV{MAIL_TO}";
		my $reply_to = $mail_to;
		my $mail_form = "$ENV{MAIL_FROM}";
		my $smtp_server = "$ENV{SMTP_SRV}";
		my $new_file = $file.".".join (".", split /\//, $current_date);
		rename 	$file, $new_file;
		qx ($blat_dir\\blat.exe - -body "┬эшьрэшх!!! ╨рчЁє°хэр срчр эрёЄЁюхъ эр ёхЁтхЁх $ENV{SERVER_HOST}, эхюсїюфшью ёюїЁрэшЄ№ ¤Єє срчє" -charset "windows-1251" -f "$mail_form" -priority "1" -replyto "$reply_to" -server "$smtp_server" -subject "╬°шсър яЁш яЁютхфхэшш ЄхёЄют яЁюшчтюфшЄхы№эюёЄш" -replyto "$reply_to" -to "$mail_to");		
		my $main = MainWindow->new();
		$main->title("Error user data base damaged!!!");
		$label_text = "Error user data base damaged!!!\nCan\'t continue tests, see log: $new_file";
		my $label = $main->Label(-text => $label_text);	
		my $button = $main->Button();
		my $icon = $button->Photo(-file => 'warning.bmp');
		$button->configure(-image => $icon, -command => sub { exit; });	
		$label->pack(-side => 'top');
		$button->pack(-side => 'top', -pady => 5);
		MainLoop();
	} else {
		print "String not found. Tests should continue\n";
	}
} else {
	print "Error invalid args.\nUsage:\n\t-f <file path>\n\t-s <string for searching>\n";
}