# Создание итогового отчета на основании лога выполнения GUI тестов замера производительности
# и сравнение с эталонными результатами
use strict;
use warnings;

use Getopt::Long;
use Common;
use ParamManager;
use Etalon;

our %options;
my %map;
# res_file путь к файлу с результатами тестов
# etalon_file путь к ini файлу с эталонными значениями
# log_file путь к файлу с результатами сравнения полученных и эталонных значений
GetOptions (\%options, "res_file=s",  "log_file=s", "etalon_file=s");

#Проверяем наличие всех аргументов командной строки
if ( exists($options{'res_file'}) && exists($options{'etalon_file'}) && exists($options{'log_file'}) ) {
	# Читаем содержимое файла с результатами производительности
	open (F_READ, "<$options{'res_file'}") || die "Can't open file: $options{'res_file'}";
	my @fileStrings = <F_READ>;
	close (F_READ) || die "Can't close file f_read";
	# Заполняем хэш массивов данными теста
	my $buffer = '';
	foreach my $item (@fileStrings) {
		if ( $item =~ /вкладки: (\d+[\.\,]\d+).*/ ) { #Задержка открытия вкладки СКР
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"04. Задержка открытия вкладки СКР: "}}, $buffer;
		}
		if ( $item =~ /регистрации: (\d+[\.\,]\d+).*/ ) { #Записываем задержку окна регистрации
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"01. Задержка окна регистрации: "}}, $buffer;
		}
		if ( $item =~ /ОМ: (\d+[\.\,]\d+).*/ ) { #Задержка открытия ОМ
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"02. Задержка открытия ОМ: "}}, $buffer;
		}
		if ( $item =~ /занял (\d+[\.\,]\d+).*/ ) { #Поиск контекста в ГК
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"05. Поиск контекста в ГК: "}}, $buffer;
		}
		if ( $item =~ /поиска: (\d+[\.\,]\d+).*/ ) { #Морфопоиск через ППР
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"07. Морфопоиск через ППР: "}}, $buffer;
		}
		if ( $item =~ /списке: (\d+[\.\,]\d+).*/ ) { #Контекстный поиск в списке
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"09. Контекстный поиск в списке: "}}, $buffer;
		}
		if ( $item =~ /ГК: (\d+[\.\,]\d+).*/ ) { #Задержка открытия ГК из профайлера
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"03. Задержка открытия ГК: "}}, $buffer;
		}
		if ( $item =~ /ППР: (\d+[\.\,]\d+).*/ ) { #Задержка открытия КЗ ППР
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"06. Задержка открытия КЗ ППР: "}}, $buffer;
		}
		if ( $item =~ /документов: (\d+[\.\,]\d+).*/ ) { #Задержка построения списка всех документов
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"08. Задержка построения списка всех документов: "}}, $buffer;
		}
		if ( $item =~ /поиска БП: (\d+[\.\,]\d+).*/ ) { #Контекстный поиск БП
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"10. Задержка БП: "}}, $buffer;
		}
		if ( $item =~ /списка после БП: (\d+[\.\,]\d+).*/ ) { #Построение списка после БП
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"11. Задержка построение списка после БП: "}}, $buffer;
		}
		if ( $item =~ /документа после БП: (\d+[\.\,]\d+).*/ ) { #Задержка открытия документа после БП 
			$buffer = $1;
			$buffer =~ s/\,/\./;
			push @{$map{"12. Задержка открытия документа после БП: "}}, $buffer;
		}
	}
	# Записываем данные из хэша массивов в конец файла
	# - печатаем все результаты и средние значения
	open (F_WRIGHT, ">>$options{'res_file'}") || die "Can't open file log file";
	print "### 1. FILE OPENED 4 WRIGHT";
	print F_WRIGHT "\n ######### ИТОГО ######### \n";
	print "### 1. ИТОГО printed";
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
		print F_WRIGHT ("Результаты: ", join (' ', @{$map{$key}}), "\n");
		print F_WRIGHT ("Среднее значение ", $out_map{$key},"\n\n");
	}
	close (F_WRIGHT) || die "Can't close file f_wright";
	# читаем из ini файла эталонные значения в хэш
	my %iniHash = ParamManager::get_ini_hash($options{'etalon_file'});
	# Сравниваем кол-во полученных и эталонных значений
	Etalon::check_with_etalon ($options{'log_file'}, \%out_map, \%{$iniHash{Etalon::GUI}}); #\%{${$iniHash{'GUI_Perfomance_Etalon'}}}
}else{
  print "Params error: use 'report2.pl -res_file <peromance result file> -etalon_file <etalon ini file> -log_file <cpmpare results file>'"
}
#if (scalar @SKROpenResults > 0 ) {
#  	foreach (@SKROpenResults) {
#    	print F_WRIGHT "$_\n";
#  	}
#  	print F_WRIGHT ("Количество итераций ", scalar @SKROpenResults, "\n");
#}