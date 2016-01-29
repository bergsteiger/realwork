# �������� ��������� ������ �� ��������� ���� ���������� GUI ������ ������ ������������������
use strict;
use warnings;

our ($mFile);
$mFile = "d:\\\#perl_ex\\�� 19.04.2006.log";

if ($ARGV[0]){
	$mFile = $ARGV[0];
}

open (F_READ, "<$mFile") || die "Can't open file f_read.txt";
my @fileStrings = <F_READ>;
close (F_READ) || die "Can't close file f_read";

my %map;
foreach my $item (@fileStrings) {
	if ( $item =~ / ��: (\d+)/ ) { #�������� �������� ������� ���
		push @{$map{"1. �� �� ��: "}}, $1;
  }
	if ( $item =~ /���������: (\d+)/ ) { #���������� �������� ���� �����������
		push @{$map{"2. ����������� ����� �� ����������� ���������: "}}, $1;
  }
	if ( $item =~ /���������: (\d+)/ ) { #�������� �������� ��
		push @{$map{"3. ��� ������� �� ���������: "}}, $1;
  }
	if ( $item =~ /�� ��: (\d+) / ) { #����� ��������� � ��
		push @{$map{"4.�� ��: "}}, $1;
  }
	if ( $item =~ /�� ��: (\d+) / ) { #���������� ����� ���
		push @{$map{"5.�� ��: "}}, $1;
  }
	if ( $item =~ /���: (\d+) / ) { #����������� ����� � ������
		push @{$map{"6.������ ���: "}}, $1;
  }
	if ( $item =~ /���: (\d+) / ) { #�������� �������� �� �� ����������
		push @{$map{"7.��������� � ������ ���: "}}, $1;
  }
	if ( $item =~ /���: (\d+) / ) { #�������� �������� �� ���
		push @{$map{"8.������ ���: "}}, $1;
  }
	if ( $item =~ /���: (\d+) / ) { #�������� ���������� ������ ���� ����������
		push @{$map{"9.������������� ���: "}}, $1;
  }
	if ( $item =~ /��: (\d+) / ) { #�������� ���������� ������ ���� ����������
		push @{$map{"10.���� ��: "}}, $1;
  }
}
# Add final report to end of log
open (F_WRIGHT, ">>$mFile") || die "Can't open file log file";
print "### 1. FILE OPENED 4 WRIGHT";
print F_WRIGHT "\n ######### ����� ######### \n";
print "### 1. ����� printed";
my %out_map = ();
foreach my $key (sort keys %map) {
	my $sum = 0;
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
#if (scalar @SKROpenResults > 0 ) {
#  	foreach (@SKROpenResults) {
#    	print F_WRIGHT "$_\n";
#  	}
#  	print F_WRIGHT ("���������� �������� ", scalar @SKROpenResults, "\n");
#}

close (F_WRIGHT) || die "Can't close file f_wright";