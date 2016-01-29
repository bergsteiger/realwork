# Создание итогового отчета на основании лога выполнения GUI тестов замера производительности
use strict;
use warnings;

our ($mFile);
$mFile = "d:\\\#perl_ex\\Ср 19.04.2006.log";

if ($ARGV[0]){
	$mFile = $ARGV[0];
}

open (F_READ, "<$mFile") || die "Can't open file f_read.txt";
my @fileStrings = <F_READ>;
close (F_READ) || die "Can't close file f_read";

my %map;
foreach my $item (@fileStrings) {
	if ( $item =~ / АО: (\d+)/ ) { #Задержка открытия вкладки СКР
		push @{$map{"1. фз об АО: "}}, $1;
  }
	if ( $item =~ /обществах: (\d+)/ ) { #Записываем задержку окна регистрации
		push @{$map{"2. федеральный закон об акционерных обществах: "}}, $1;
  }
	if ( $item =~ /упрощенку: (\d+)/ ) { #Задержка открытия ОМ
		push @{$map{"3. НДС переход на упрощенку: "}}, $1;
  }
	if ( $item =~ /ГК РФ: (\d+) / ) { #Поиск контекста в ГК
		push @{$map{"4.ГК РФ: "}}, $1;
  }
	if ( $item =~ /нк РФ: (\d+) / ) { #Морфопоиск через ППР
		push @{$map{"5.нк РФ: "}}, $1;
  }
	if ( $item =~ /ФНС: (\d+) / ) { #Контекстный поиск в списке
		push @{$map{"6.письмо ФНС: "}}, $1;
  }
	if ( $item =~ /ккм: (\d+) / ) { #Задержка открытия ГК из профайлера
		push @{$map{"7.включение в реестр ккм: "}}, $1;
  }
	if ( $item =~ /есн: (\d+) / ) { #Задержка открытия КЗ ППР
		push @{$map{"8.ставка есн: "}}, $1;
  }
	if ( $item =~ /ЗАО: (\d+) / ) { #Задержка построения списка всех документов
		push @{$map{"9.реорганизация ЗАО: "}}, $1;
  }
	if ( $item =~ /цб: (\d+) / ) { #Задержка построения списка всех документов
		push @{$map{"10.курс цб: "}}, $1;
  }
}
# Add final report to end of log
open (F_WRIGHT, ">>$mFile") || die "Can't open file log file";
print "### 1. FILE OPENED 4 WRIGHT";
print F_WRIGHT "\n ######### ИТОГО ######### \n";
print "### 1. ИТОГО printed";
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
	print F_WRIGHT ("Результаты: ", join (' ', @{$map{$key}}), "\n");
	print F_WRIGHT ("Среднее значение ", $out_map{$key},"\n\n");
}
#if (scalar @SKROpenResults > 0 ) {
#  	foreach (@SKROpenResults) {
#    	print F_WRIGHT "$_\n";
#  	}
#  	print F_WRIGHT ("Количество итераций ", scalar @SKROpenResults, "\n");
#}

close (F_WRIGHT) || die "Can't close file f_wright";