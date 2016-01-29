package Etalon;

use strict;

use ParamManager;
use Common;
# ключи для доступа к хэшу с эталонными данными
use constant GUI => 'GUI_Perfomance_Etalon';
use constant CONSOLE => 'Console_Perfomance_Etalon';


sub check_with_etalon {
  my ($log_file, $res_hash, $et_hash) = @_;
  #Если существует файл с логом работы, удаляем его
  if (-e $log_file){
    qx (del "$log_file");
  }
	# Сравниваем кол-во полученных и эталонных значений
	if ( scalar keys %{$et_hash} != scalar keys %{$res_hash} ) {
		my $etalon_size = scalar keys %{$et_hash};
		my $result_size = scalar keys %{$res_hash};
		Common::add_line_to_file($log_file, "ОШИБКА: Кол-во полученных значений: $result_size не равно кол-ву эталонных значений: $etalon_size\n");
	}
	foreach my $etalon_key ( sort keys %{$et_hash} ){
    #if (!exists(${%{$res_hash}}{$etalon_key}) ) {
		if (exists($${res_hash}{$etalon_key}) ) {
			#if ( ${%{$res_hash}}{$etalon_key} > ${%{$et_hash}}{$etalon_key} * 1.1 ) { #результат на 10% больше эталона
      if ( $${res_hash}{$etalon_key} > $${et_hash}{$etalon_key} * 1.1 || ($${res_hash}{$etalon_key} - $${et_hash}{$etalon_key}) > 0.5) { #результат на 10% больше эталона
        
				Common::add_line_to_file ($log_file, ":-[ УВЕЛИЧЕНИЕ: Параметр '$etalon_key' эталон: ". scalar $${et_hash}{$etalon_key}." результат: ". scalar $${res_hash}{$etalon_key} ."\n");
			}
			if ( $${res_hash}{$etalon_key} < $${et_hash}{$etalon_key} * 0.9 || ($${et_hash}{$etalon_key} - $${res_hash}{$etalon_key}) > 0.5) { #результат на 10% меньше эталона
				Common::add_line_to_file ($log_file, ":-D УМЕНЬШЕНИЕ: Параметр '$etalon_key' эталон: ". scalar $${et_hash}{$etalon_key} ." результат: ". scalar $${res_hash}{$etalon_key} ."\n");
			}
		}else{
      Common::add_line_to_file ($log_file, "ОШИБКА: В результатах отсутвует параметр $etalon_key\n");
		}
	}
}


1;