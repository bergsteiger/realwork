package GUI_Memory_Tests;

use Common;
use strict;

sub test {
	print "GUI_Memory_Tests\n";
}

# 		Открытие_документов
#		Открытие_списков
#		Поиски_по_ППР
#		Поиски_по_ППР_1_контекст
#		Логин_логаут_одним_пользователем

sub run {
	my ($config) = @_;
	Common::get_clean_settings ($config);
	my @tests_arr = split /;/, $config->{"MEMORY_TESTS"}->{"TESTS"};
	my %tests = Common::prepare_tests_hash ($config);
#	$tests{"Открытие_документов"} = 350;
#	$tests{"Открытие_списков"} = 200;
#	$tests{"Поиски_по_ППР"} = 70;
#	$tests{"Поиски_по_ППР_1_контекст"} = 50;
#	$tests{"Логин_логаут_одним_пользователем"} = 50;
	
	my $tc = $config->{"MAIN"}->{"TC_PATH"};
	my $tc_proj = $config->{"MAIN"}->{"TC_PROJECT_PATH"} . "\\memoryusing.mds";
	foreach my $key (%tests) {
		Common::get_clean_settings ($config);
		qx ($tc /RunAndExit $tc_proj ps_tools_path=$config->{"MAIN"}->{"PS_TOOLS_PATH"} mem_test_op=$key iter_count=$tests{$key});
	}	
}


1;