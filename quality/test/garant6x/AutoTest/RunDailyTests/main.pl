use Common;
use ParamManager;
use Getopt::Std;
use strict;

our ($opt_f);
getopts ('f:');

my $config = ParamManager::load_config ($opt_f);
my $build_flag = $config->{"MAIN"}->{"DISTRIB_PATH"}. "\\!daily.build-script-schedule.lock";

while (-e "$build_flag") {
	sleep 100;
}
qx (regedit -s redirect_client.reg);

#Запускаем тесты;
my @tests_array = split /;/, $config->{"MAIN"}->{"READY_TESTS"};
foreach my $item (@tests_array) {
	eval ("use $item");
	my $func = $item . "::run";
	*code = \&{$func};
	if (defined(&code)) {
		&code($config);
	} else {
		print "can't execute $func";
	}
}





