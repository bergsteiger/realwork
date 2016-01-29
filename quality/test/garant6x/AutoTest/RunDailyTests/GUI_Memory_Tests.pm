package GUI_Memory_Tests;

use Common;
use strict;

sub test {
	print "GUI_Memory_Tests\n";
}

# 		��������_����������
#		��������_�������
#		������_��_���
#		������_��_���_1_��������
#		�����_������_�����_�������������

sub run {
	my ($config) = @_;
	Common::get_clean_settings ($config);
	my @tests_arr = split /;/, $config->{"MEMORY_TESTS"}->{"TESTS"};
	my %tests = Common::prepare_tests_hash ($config);
#	$tests{"��������_����������"} = 350;
#	$tests{"��������_�������"} = 200;
#	$tests{"������_��_���"} = 70;
#	$tests{"������_��_���_1_��������"} = 50;
#	$tests{"�����_������_�����_�������������"} = 50;
	
	my $tc = $config->{"MAIN"}->{"TC_PATH"};
	my $tc_proj = $config->{"MAIN"}->{"TC_PROJECT_PATH"} . "\\memoryusing.mds";
	foreach my $key (%tests) {
		Common::get_clean_settings ($config);
		qx ($tc /RunAndExit $tc_proj ps_tools_path=$config->{"MAIN"}->{"PS_TOOLS_PATH"} mem_test_op=$key iter_count=$tests{$key});
	}	
}


1;