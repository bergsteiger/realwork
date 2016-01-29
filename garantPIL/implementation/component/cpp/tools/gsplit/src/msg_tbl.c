#include "../../../libs/mrglib/src/gdbapi.h"
#include "gardefs.h"
#include <string.h>
#include <stdlib.h>

char *rus_msg[] = {
	"Создание комплекта системы ГАРАНТ ",
	"",
	"Внимание: будет создано только %d баз.",
	"Не удается открыть исходную базу %s.",
	"База %s не прошла необходимой обработки.",
	"Создание списка документов новой базы...", /*5*/
	"Создание базы данных : шаг ",
	"1 из 3",
	"2 из 3",
	"3 из 3",
	"Построение поисковых индексов : шаг ", /*10*/
	"1 из 59",
	"2 из 59",
	"3 из 59",
	"4 из 59",
	"5 из 59",
	"6 из 59",
	"7 из 59",
	"8 из 59",
	"9 из 59",
	"10 из 59",
	"11 из 59",
	"12 из 59",
	"13 из 59",
	"14 из 59",
	"15 из 59",
	"16 из 59",
	"17 из 59",
	"18 из 59",
	"19 из 59",
	"20 из 59",
	"21 из 59",
	"22 из 59",
	"23 из 59",
	"24 из 59",
	"25 из 59",
	"26 из 59",
	"27 из 59",
	"28 из 59",
	"29 из 59",
	"30 из 59",
	"31 из 59",
	"32 из 59",
	"33 из 59",
	"34 из 59",
	"35 из 59",
	"36 из 59",
	"37 из 59",
	"38 из 59",
	"39 из 59",
	"40 из 59",
	"41 из 59",
	"42 из 59",
	"43 из 59",
	"44 из 59",
	"45 из 59",
	"46 из 59",
	"47 из 59",
	"48 из 59",
	"49 из 59",
	"50 из 59",
	"51 из 59",
	"52 из 59",
	"53 из 59",
	"54 из 59",
	"55 из 59",
	"56 из 59",
	"57 из 59",
	"58 из 59",
	"59 из 59",
	"Комплект создан успешно",
	"Версия ",
	"Заданный комплект не может быть создан.",
	"Заданные комплекты не могут быть созданы."
};

char *eng_msg[] = {
	"Garant database splitter. ",
	"",
	"Warning: only %d bases will be built.",
	"Can't open source base %s",
	"Source base %s isn't ready to splitting.",
	"Collecting documents list...",
	"Building database : step ",
	"1 of 3",
	"2 of 3",
	"3 of 3",
	"Building indexes : step ",
	"1 of 59",
	"2 of 59",
	"3 of 59",
	"4 of 59",
	"5 of 59",
	"6 of 59",
	"7 of 59",
	"8 of 59",
	"9 of 59",
	"10 of 59",
	"11 of 59",
	"12 of 59",
	"13 of 59",
	"14 of 59",
	"15 of 59",
	"16 of 59",
	"17 of 59",
	"18 of 59",
	"19 of 59",
	"20 of 59",
	"21 of 59",
	"22 of 59",
	"23 of 59",
	"24 of 59",
	"25 of 59",
	"26 of 59",
	"27 of 59",
	"28 of 59",
	"29 of 59",
	"30 of 59",
	"31 of 59",
	"32 of 59",
	"33 of 59",
	"34 of 59",
	"35 of 59",
	"36 of 59",
	"37 of 59",
	"38 of 59",
	"39 of 59",
	"40 of 59",
	"41 of 59",
	"42 of 59",
	"43 of 59",
	"44 of 59",
	"45 of 59",
	"46 of 59",
	"47 of 59",
	"48 of 59",
	"49 of 59",
	"50 of 59",
	"51 of 59",
	"52 of 59",
	"53 of 59",
	"54 of 59",
	"55 of 59",
	"56 of 59",
	"57 of 59",
	"58 of 59",
	"Splitting process finished successfully",
	"Version ",
	"Error: nonexistent segments selected.",
	"Error: nonexistent segments selected."
};

char **msg_table = rus_msg;
int gsplit_language = 0;

int get_language()
{
	return gsplit_language;
}

void set_language(int lang)
{
	gsplit_language = lang;
	if(lang) msg_table = eng_msg;
	else msg_table = rus_msg;
}

char *get_message(int msg)
{
	if(msg < 0 || msg >= sizeof(rus_msg)/sizeof(*rus_msg)) return 0;
	return msg_table[msg];
}
