# �������� ��������� ������ �� ��������� ���� ���������� GUI ������ ������ ������������������
# � ��������� � ���������� ������������
use strict;
use warnings;

use Getopt::Long;
use Common;
use ParamManager;
use Etalon;

our %options;
my %map;
# res_file ���� � ����� � ������������ ������
# etalon_file ���� � ini ����� � ���������� ����������
# log_file ���� � ����� � ������������ ��������� ���������� � ��������� ��������
GetOptions (\%options, "res_file=s",  "log_file=s", "etalon_file=s");

#��������� ������� ���� ���������� ��������� ������
if ( exists($options{'res_file'}) && exists($options{'etalon_file'}) && exists($options{'log_file'}) ) {
	# ������ ���������� ����� � ������������ ������������������
	open (F_READ, "<$options{'res_file'}") || die "Can't open file: $options{'res_file'}";
	my @fileStrings = <F_READ>;
	close (F_READ) || die "Can't close file f_read";
	# ��������� ��� �������� ������� �����
	my $buffer = '';
	foreach my $item (@fileStrings) {
		if ( $item =~ /�������: (\d+[\.\,]\d+).*/ ) { #�������� �������� ������� ���
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"04. �������� �������� ������� ���: "}}, $buffer;
		}
		if ( $item =~ /�����������: (\d+[\.\,]\d+).*/ ) { #���������� �������� ���� �����������
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"01. �������� ���� �����������: "}}, $buffer;
		}
		if ( $item =~ /��: (\d+[\.\,]\d+).*/ ) { #�������� �������� ��
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"02. �������� �������� ��: "}}, $buffer;
		}
		if ( $item =~ /����� (\d+[\.\,]\d+).*/ ) { #����� ��������� � ��
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"05. ����� ��������� � ��: "}}, $buffer;
		}
		if ( $item =~ /������: (\d+[\.\,]\d+).*/ ) { #���������� ����� ���
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"07. ���������� ����� ���: "}}, $buffer;
		}
		if ( $item =~ /������: (\d+[\.\,]\d+).*/ ) { #����������� ����� � ������
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"09. ����������� ����� � ������: "}}, $buffer;
		}
		if ( $item =~ /��: (\d+[\.\,]\d+).*/ ) { #�������� �������� �� �� ����������
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"03. �������� �������� ��: "}}, $buffer;
		}
		if ( $item =~ /���: (\d+[\.\,]\d+).*/ ) { #�������� �������� �� ���
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"06. �������� �������� �� ���: "}}, $buffer;
		}
		if ( $item =~ /����������: (\d+[\.\,]\d+).*/ ) { #�������� ���������� ������ ���� ����������
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"08. �������� ���������� ������ ���� ����������: "}}, $buffer;
		}
		if ( $item =~ /������ ��: (\d+[\.\,]\d+).*/ ) { #����������� ����� ��
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"10. �������� ��: "}}, $buffer;
		}
		if ( $item =~ /������ ����� ��: (\d+[\.\,]\d+).*/ ) { #���������� ������ ����� ��
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"11. �������� ���������� ������ ����� ��: "}}, $buffer;
		}
		if ( $item =~ /��������� ����� ��: (\d+[\.\,]\d+).*/ ) { #�������� �������� ��������� ����� �� 
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"12. �������� �������� ��������� ����� ��: "}}, $buffer;
		}
	}
	# ���������� ������ �� ���� �������� � ����� �����
	# - �������� ��� ���������� � ������� ��������
	open (F_WRIGHT, ">>$options{'res_file'}") || die "Can't open file log file";
	print "### 1. FILE OPENED 4 WRIGHT";
	print F_WRIGHT "\n ######### ����� ######### \n";
	print "### 1. ����� printed";
	my %out_map = ();
	foreach my $key (sort keys %map) {
		my $sum = 0.0;
		my $idx = $#{$map{$key}};
		foreach my $item1 (@{$map{$key}}) {
			$sum += $item1;
		}
		$out_map{$key} = $sum/($idx+1);
		#print join(' ' ,@{$map{$_}}),"\n";
		#print @{$map{$_}},"\n";
	}
	foreach my $key (sort keys %out_map) {
		print F_WRIGHT ("\n\n$key\n");
		print F_WRIGHT ("����������: ", join (' ', @{$map{$key}}), "\n");
		print F_WRIGHT ("������� �������� ", $out_map{$key},"\n\n");
	}
	close (F_WRIGHT) || die "Can't close file f_wright";
	# ������ �� ini ����� ��������� �������� � ���
	my %iniHash = ParamManager::get_ini_hash($options{'etalon_file'});
	# ���������� ���-�� ���������� � ��������� ��������
	Etalon::check_with_etalon ($options{'log_file'}, \%out_map, \%{$iniHash{Etalon::GUI}}); #\%{${$iniHash{'GUI_Perfomance_Etalon'}}}
}else{
  print "Params error: use 'report2.pl -res_file <peromance result file> -etalon_file <etalon ini file> -log_file <cpmpare results file>'"
}
#if (scalar @SKROpenResults > 0 ) {
#  	foreach (@SKROpenResults) {
#    	print F_WRIGHT "$_\n";
#  	}
#  	print F_WRIGHT ("���������� �������� ", scalar @SKROpenResults, "\n");
#}