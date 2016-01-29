package Etalon;

use strict;

use ParamManager;
use Common;
# ����� ��� ������� � ���� � ���������� �������
use constant GUI => 'GUI_Perfomance_Etalon';
use constant CONSOLE => 'Console_Perfomance_Etalon';


sub check_with_etalon {
  my ($log_file, $res_hash, $et_hash) = @_;
  #���� ���������� ���� � ����� ������, ������� ���
  if (-e $log_file){
    qx (del "$log_file");
  }
	# ���������� ���-�� ���������� � ��������� ��������
	if ( scalar keys %{$et_hash} != scalar keys %{$res_hash} ) {
		my $etalon_size = scalar keys %{$et_hash};
		my $result_size = scalar keys %{$res_hash};
		Common::add_line_to_file($log_file, "������: ���-�� ���������� ��������: $result_size �� ����� ���-�� ��������� ��������: $etalon_size\n");
	}
	foreach my $etalon_key ( sort keys %{$et_hash} ){
    #if (!exists(${%{$res_hash}}{$etalon_key}) ) {
		if (exists($${res_hash}{$etalon_key}) ) {
			#if ( ${%{$res_hash}}{$etalon_key} > ${%{$et_hash}}{$etalon_key} * 1.1 ) { #��������� �� 10% ������ �������
      if ( $${res_hash}{$etalon_key} > $${et_hash}{$etalon_key} * 1.1 || ($${res_hash}{$etalon_key} - $${et_hash}{$etalon_key}) > 0.5) { #��������� �� 10% ������ �������
        
				Common::add_line_to_file ($log_file, ":-[ ����������: �������� '$etalon_key' ������: ". scalar $${et_hash}{$etalon_key}." ���������: ". scalar $${res_hash}{$etalon_key} ."\n");
			}
			if ( $${res_hash}{$etalon_key} < $${et_hash}{$etalon_key} * 0.9 || ($${et_hash}{$etalon_key} - $${res_hash}{$etalon_key}) > 0.5) { #��������� �� 10% ������ �������
				Common::add_line_to_file ($log_file, ":-D ����������: �������� '$etalon_key' ������: ". scalar $${et_hash}{$etalon_key} ." ���������: ". scalar $${res_hash}{$etalon_key} ."\n");
			}
		}else{
      Common::add_line_to_file ($log_file, "������: � ����������� ��������� �������� $etalon_key\n");
		}
	}
}


1;